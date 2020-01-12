function [E_n_double, TRI, sp] = Edges(spheres, cutoff, cyclic_boundary)
w = 20;
sp = wrap_sp_with_periodic_bd(spheres, cyclic_boundary, w);

d = @(r1,r2) norm(r1-r2);
TRI = delaunay(sp(:,1),sp(:,2));
E0 = [TRI(:,1) TRI(:,2); TRI(:,2) TRI(:,3); TRI(:,3) TRI(:,1)];
E = [];
for i=1:length(E0)
    e = E0(i,:);
    e = [min(e) max(e)];
    r1 = sp(e(1),1:2);
    r2 = sp(e(2),1:2);
    if d(r1,r2) <= cutoff
        E = [E; e];
    end
end
[~,I] = sort(E(:,1));
E = E(I,:);
E_n_double = [];
for i=1:length(sp)
    bonds_w_i = E(:,1)==i;
    J = E(bonds_w_i,2);
    if isempty(J)
        continue;
    end
    J = sort(J);
    J = [J(~(J(1:end-1)==J(2:end))); J(end)];
    E_n_double = [E_n_double; [ones(size(J))*i J]];
end
end