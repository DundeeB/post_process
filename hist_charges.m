function arcs = hist_charges(lib, num, E)
load([lib '\state ' num2str(num) '.mat']);
x = state.spheres(:,1);
y = state.spheres(:,2);
if nargin == 2
    E = knn_based_bonds(state,3,false);
    E = bonds_from_directed_graph(E, state, 3, true);
    L = max(state.cyclic_boundary(1:2));
    axis equal;
    xlim([0 L]);
    ylim([0 L]);
end
%%
s = E(:,1); t = E(:,2);
G = graph(s,t);

obj=polyregions(G,x,y);
pgon=polyshape(obj);
%%
arcs = [];
for i=1:length(pgon)
    arcs(end+1)=length(pgon(i).Vertices);
end

figure;
[counts,centers]=hist(arcs,2:100);
plot(centers,counts/trapz(centers,counts),'.--','MarkerSize',30,'LineWidth',2);
set(gca,'FontSize',20);
grid on;
xlabel('length(cycle)');
ylabel('pdf');
end