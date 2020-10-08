function [g, counts] = g_z_dist_by_graph_undirected(state, E, N_couples, isplot)
g = zeros(length(state.spheres),1);
counts = zeros(size(g));

z = (state.spheres(:,3)-state.H/2)/((state.H-2*state.rad)/2);
psi_z = exp(1i*pi/2*z);

A = sparse([E(:,1); E(:,2)],[E(:,2);E(:,1)],1);
couples = randi(length(state.spheres), [N_couples 2]);
for i=1:N_couples
    s = couples(i,1); t = couples(i,2);
    if s==t
        continue;
    end
    [L,P] = graphshortestpath(A,s,t);
    if L~=Inf
        for L=2:length(P)
            t = P(L);
            g(L) = g(L) + psi_z(s)*psi_z(t)';
            counts(L) = counts(L) + 1;
        end            
    end
end
I = counts>100;
counts = counts(I);
g = g(I);
g = g./counts;
if nargin>3 && isplot
    subplot(2,1,1);
    semilogx(real(g),'.','MarkerSize',20);hold all;
    set(gca,'fontsize',18);
    ylabel('real(<\psi_z\psi_z^*>)'); ylim([-1 1]);
%     legend('');
    subplot(2,1,2);
%     semilogx(counts,'.--','LineWidth',2,'MarkerSize',20);
    loglog(abs(real(g)),'--','LineWidth',2, 'MarkerSize',20);
    ylim([0.1 1]);
    set(gca,'fontsize',18);hold all;
    xlabel('Topological distance');
%     ylabel('Counts');
    ylabel('|real(<\psi_z\psi_z^*>)|');
end
end