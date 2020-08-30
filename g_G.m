function [g, rc, counts] = g_G(state, G, isplot)
sp_xy = state.spheres(:,1:2);
G = reshape(G,[2 1]);
psi_G = exp(1i*sp_xy*G);
[g, rc, counts] = g_mn(state, psi_G, isplot);
if isplot
    ylabel('g_{G}(\Deltar)');
end
end