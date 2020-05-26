function [psimn_vec, E] = psi_mn(m, n, state, isplot)
%psi_mn = abs(psi_n)*exp(i*m*angle(psi_n)) where
%psi_n = sum_{nearest neighbors} exp(i*n*t) and t is the angle of the bond
%between the sphere and its nearest neighbor. psimn_vec is a vector where
%for the i'th sphere its local psi_mn is psimn_vec(i). The number of
%nearest neighbors is n, and if they are oriented in 2pi/n then psi_n will
%be 1. If there are N>n equivelent angle, then m=N/n. For example, in the
%honeycomb lattice there are N=6 equivelent angles, and each sphere has n=3
%nearest neighbors, and so m=2, and psi_23 is the correct order parameter.
%For triangular lattice N=n=6 and m=1, and for square N=n=4 and m=1.
if nargin<4
    isplot = false;
end
spheres = state.spheres;
psimn_vec = zeros(length(spheres),1);
E = knn_based_bonds(state, n, isplot);
% E = bonds_from_directed_graph(E, state, n, true);
psi_n = zeros(size(psimn_vec));
Neighbors = zeros(size(psimn_vec));
for i=1:length(E)
    a = E(i,1); b = E(i,2);
    r1 = spheres(a,:); r2 = spheres(b,:);
    dr = r1 - r2;
    t = atan2(dr(2),dr(1));
    psi_n(a) = psi_n(a) + exp(1i*n*t);
    Neighbors(a) = Neighbors(a) + 1;
end
I = Neighbors~=0;
psi_n(I) = psi_n(I)./Neighbors(I);
psimn_vec = abs(psi_n).*exp(1i*m*angle(psi_n));
if isplot
    quiver(spheres(:,1), spheres(:,2), real(psimn_vec),imag(psimn_vec));
end