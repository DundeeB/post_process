function [spheres] = ferro_triang_starting_cond3D(N, box, r)
n = N(1)*N(2);
if length(N) ~= 2
    assert(N(3) == 1);
end
spheres = zeros(n,length(N));
dr = box./(N+1/2);
for i=1:N(2)
    for j=1:N(1)
        if mod(i,2) == 1
            xj = dr(1)*(j-1/2);
        else
            xj = dr(1)*j;
        end
        y = dr(2)*(i-1/2);
        spheres((i-1)*N(1)+j,:) = [xj y r*1.001];
    end
end
end

