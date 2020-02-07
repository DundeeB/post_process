function [psipsi, xij, yij] = orientational_pairs(state, m, n)
[xij,yij,~,~] = positional_pairs(state,m,n);
psi = psi_mn(m,n,state.spheres,state.cyclic_boundary);
psipsi = psi*psi';
end