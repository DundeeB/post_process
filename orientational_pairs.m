function [psipsi, xij, yij] = orientational_pairs(state,m,n,...
    nearest_neighbors_cut_off, H, different_heights_cond)
sp = state.spheres/state.rad;
x = sp(:,1); y = sp(:,2);
N = length(sp);
psi = zeros(N,1);
for a=1:N
    [psi_,~] = psi_mn(a,m,n,sp,nearest_neighbors_cut_off, H, different_heights_cond);
    psi(a) = psi_;
end
[xij,yij,~,~] = positional_pair(state,m,n);
psipsi = psi*psi';
end