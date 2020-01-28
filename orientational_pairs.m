function [psipsi, xij, yij] = orientational_pairs(state, m, n, varargin)
[xij,yij,~,~] = positional_pair(state,m,n);
psi = psi_mn(m,n,state.spheres,varargin{:});
psipsi = psi*psi';
end