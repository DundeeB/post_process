function [E] = knn_based_bonds(spheres, k, varargin)
E = [];
for i=1:length(spheres)
    knn = knnsearch(spheres(:,1:2), spheres(i,1:2),'k',k+1);
    for j=knn
        if j==i
            continue
        end
        E = [E; [i j]];
    end
end
x = spheres(:,1);
y = spheres(:,2);

if nargin > 2
    isplot = varargin{1};
    if isplot
        figure; hold on;
        plot(x,y,'.Black','MarkerSize',20);
        for i=1:length(E)
            e=E(i,:);
            plot(x(e),y(e),'-m');
        end
    end
end
end