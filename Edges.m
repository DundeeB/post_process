function [E, TRI] = Edges(spheres, is_del, cutoff, cyclic_boundary)
sp = spheres;

d = @(r1,r2) cyclic_dist(r1,r2,cyclic_boundary);
if is_del
    TRI = delaunay(sp(:,1),sp(:,2));
    E = [TRI(:,1) TRI(:,2); TRI(:,2) TRI(:,3); TRI(:,3) TRI(:,1)];
    if nargin == 4
        Efin = [];
        for i=1:length(E)
            e = E(i,:);
            r1 = sp(e(1),1:2);
            r2 = sp(e(2),1:2);
            if d(r1,r2) <= cutoff
                Efin = [Efin; e];
            end
        end
        E = Efin;
    end
else
    assert(nargin == 4,'nragin shoud be 4');
    E = [];
    for i=1:length(sp)
        for j=1:i-1
            r1 = sp(i,1:2);
            r2 = sp(j,1:2);
            if d(r1,r2) <= cutoff
                E = [E ; [j i]];
            end
        end
    end
end
end