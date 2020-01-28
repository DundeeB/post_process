function [psimn_vec, E] = psi_mn(m, n, spheres, cyclic_boundary)
%PSI_N find for the i'th sphere it's nearest neighbors and calculate the
%psi_n order parameter for the i'th sphere
%psi(m,n) is the order parameter 
psimn_vec = zeros(length(spheres),1);
E = knn_based_bonds(spheres, n, cyclic_boundary);
psi_n = zeros(size(psimn_vec));
Neighbors = zeros(size(psimn_vec));
for i=1:length(E)
    a = E(i,1);
    r1 = spheres(a,:);
    b = E(i,2);
    r2 = spheres(b,:);
    dr = r1 - r2;
    t = atan2(dr(2),dr(1));
    psi_n(a) = psi_n(a) + exp(1i*n*t);
    Neighbors(a) = Neighbors(a) + 1;
end
I = Neighbors~=0;
psi_n(I) = psi_n(I)./Neighbors(I);
for i=1:length(psi_n)
    psimn_vec(i) = abs(psi_n(i))*exp(1i*m*angle(psi_n(i)));
end
end