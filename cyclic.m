function [ps] = cyclic(ps, cyclic_boundary)
[N,~] = size(ps);
d = length(cyclic_boundary);
for i=1:d
    ps(1:N,i) = mod(ps(1:N,i),cyclic_boundary(i));
end
end

