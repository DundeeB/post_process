function [ps] = cyclic_vec(ps, cyclic_boundary)
[N,~] = size(ps);
d = length(cyclic_boundary);
for j=1:N
    p = ps(j,:);
    for i=1:d
        v = [p(i), p(i)+cyclic_boundary(i), p(i)-cyclic_boundary(i)];
        [~,k] = min(abs(v));
        p(i) = v(k);
    end
    ps(j,:) = p;
end
end

