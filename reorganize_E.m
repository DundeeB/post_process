load('C:\Users\Daniel Abutbul\OneDrive - Technion\post_process\from_ATLAS\N=3600_h=1_rhoH=0.85\state.mat');
x = state.spheres(:,1);
y = state.spheres(:,2);

load('C:\Users\Daniel Abutbul\Downloads\Loops\Edges.mat');
for i=1:length(E)
    E(i,:) = sort(E(i,:));
end
E_ = [];
for i=1:length(E)
    I = E(:,1) == i;
    J = sort(E(I,2));
    J = unique(J);
    e_ = [i+J*0 J];
    for j=1:length(e_(:,1))
        try
            r = sqrt((x(e_(j,1))-x(e_(j,2)))^2+(y(e_(j,1))-y(e_(j,2)))^2);
        catch err
        end
        if r<inf%10
            E_ = [E_;e_(j,:)];
        end
        
    end
end
s = E_(:,1); t = E_(:,2);
G = graph(s,t);

obj=polyregions(G,x,y);
pgon=polyshape(obj);
plot(obj);
hold on
plot(pgon);
hold off
%%
arcs = [];
for i=1:length(pgon)
    arcs(end+1)=length(pgon(i).Vertices);
end
%%
figure;p
q = 6 - arcs;
[counts,centers]=hist(q,-6:6);
plot(centers,counts/sum(q),'.--','MarkerSize',30,'LineWidth',2);
set(gca,'FontSize',20);
grid on;
xlabel('Charge=6-length(cycle)');
ylabel('pdf');
legend('N=3600 h=1 \rho_H=0.85');