function [d] = cyclic_dist(p1,p2,cyclic_boundary)
dsq = 0;
for i=1:length(cyclic_boundary)
    direct = p1(i)-p2(i);
    L = cyclic_boundary(i);
    dsq = dsq + min([direct^2, (direct+L)^2, (direct-L)^2]);
end
I = length(cyclic_boundary)+1:length(p1);
dsq = dsq + norm(p1(I)-p2(I))^2;
d = sqrt(dsq);
end