function [E] = knn_based_bonds(spheres, k, cyclic_boundary, varargin)
% directed graph, where E(i,2) is a nearest number of sphere E(i,1)
E = [];
for i=1:length(spheres)
    [knn, D] = knnsearch(spheres(:,1:2), spheres(i,1:2), 'k', k+1, ...
        'Distance',@(ZI,ZJ) distfun_w_bc(ZI,ZJ,cyclic_boundary));
    is = i+D(D~=0)*0;
    E = [E; is' knn(D~=0)'];
end
if nargin <= 3  || ~varargin{1}
    return
end
x = spheres(:,1);
y = spheres(:,2);
z0 = mean(spheres(:,3));
up = spheres(:,3) > z0;
down = ~up;
figure; hold on;
plot(x(up),y(up),'.b','MarkerSize',15);
plot(x(down),y(down),'.r','MarkerSize',15   );
for i=1:length(E)
    e=E(i,:);
    if norm([x(e(1))-x(e(2)) y(e(1))-y(e(2))])>10
%                 plot(x(e),y(e),'--Black');
    else
        plot(x(e),y(e),'-m');
    end
end
xlim([0 cyclic_boundary(1)]);
xlim([0 cyclic_boundary(2)]);
axis equal;
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