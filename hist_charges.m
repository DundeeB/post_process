function q = hist_charges(lib, num, E)
load([lib '\state ' num2str(num) '.mat']);
% load('from_ATLAS\N=3600_h=1.0_rhoH=0.85_AF_triangle_ECMC\state 17992800.mat');
% load('from_ATLAS\N=3600_h=1.0_rhoH=0.88_AF_square_ECMC\state 12383280.mat');
% load('from_ATLAS\N=3600_h=1.0_rhoH=0.93_AF_triangle_ECMC\state 17992800.mat');
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
q = arcs;
[counts,centers]=hist(q,2:15);
plot(centers,counts/trapz(centers,counts),'.--','MarkerSize',30,'LineWidth',2);
set(gca,'FontSize',20);
grid on;
xlabel('length(cycle)');
ylabel('pdf');
legend('N=3600 h=1 \rho_H=0.93');
end