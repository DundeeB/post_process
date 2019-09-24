function [p] = psi_order_parameter(m, n, spheres, nearest_neighbors_cut_off, H)
%psi(n,m) is the order parameter 
[N, ~] = size(spheres);
p = 0;
for a=1:N
    pn = 0;
    Na = 0;
    r1 = spheres(a,:);
    for b = [1:a-1 a+1:N]
        r2 = spheres(b,:);
        if norm(r1([1,2])-r2([1,2])) < nearest_neighbors_cut_off &&...
                (r1(3)-H/2)*(r2(3)-H/2)<0  % fix it
            Na = Na + 1;
            dr = r1 - r2;
            t = atan2(dr(2),dr(1));
            pn = pn + exp(1i*n*t);
        end
    end
    if Na ~= 0
        pn = pn / Na;
        p = p + abs(pn)*exp(1i*m*angle(pn));
    else
        N = N - 1;
    end
end
if N ~= 0
    p = p/N;
end
end

