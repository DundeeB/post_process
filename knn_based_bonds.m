function [E] = knn_based_bonds(spheres, k, cyclic_boundary, isplot)
% directed graph, where E(i,2) is a nearest number of sphere E(i,1)
knn = knnsearch(spheres(:,1:2), spheres(:,1:2), 'k', k+1, ...
        'Distance',@(ZI,ZJ) distfun_w_bc(ZI,ZJ,cyclic_boundary));
E = [];
for i=1:k
    E = [E; knn(:,1) knn(:, i+1)];
end
[~,I] = sort(E(:,1));
E  = E(I,:);
if nargin > 3 && isplot
    x = spheres(:,1);
    y = spheres(:,2);
    z0 = mean(spheres(:,3));
    up = spheres(:,3) > z0;
    down = ~up;
    figure; hold on;
    for i=1:length(E)
        e=E(i,:);
        if norm([x(e(1))-x(e(2)) y(e(1))-y(e(2))])<10
            plot(x(e),y(e),'-b');
        end
    end
    plot(x(up),y(up),'.k','MarkerSize',15);
    plot(x(down),y(down),'.m','MarkerSize',15);
    L = min(cyclic_boundary(1:2));
    xlim([0 L]);
    ylim([0 L]);
end
end

function D2 = distfun_w_bc(ZI,ZJ,cyclic_boundary)
% size(ZI) = 1, n
% size(ZJ) = m2, n
% size(D2) = m2, 1
[m2,~] = size(ZJ);
D2 = zeros(m2,1);
for j=1:m2
    p1 = ZJ(j,:);
    D2(j) = cyclic_dist(p1,ZI,cyclic_boundary);
end
end