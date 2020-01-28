function [E_n_double, TRI, sp] = Edges(spheres, w, cutoff, cyclic_boundary)
sp = wrap_sp_with_periodic_bd(spheres, w, cyclic_boundary);

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
if isempty(E)
    error('Found no edges at all');
end
E_n_double = clean_doubles(E, length(sp));
end