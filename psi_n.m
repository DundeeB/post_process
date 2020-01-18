function [psi_n,Neighbors] = psi_n(i, n, spheres, ...
    nearest_neighbors_cut_off, H, different_heights_cond)
%PSI_N find for the i'th sphere it's nearest neighbors and calculate the
%psi_n order parameter for the i'th sphere
%psi(m,n) is the order parameter 
psi_n = 0;
Neighbors = 0;
r1 = spheres(i,:);
for j = [1:i-1 i+1:N]
    r2 = spheres(j,:);
    if norm(r1([1,2])-r2([1,2])) < nearest_neighbors_cut_off
        if different_heights_cond && (r1(3)-H/2)*(r2(3)-H/2)>0
            continue;
        end
        Neighbors = Neighbors + 1;
        dr = r1 - r2;
        t = atan2(dr(2),dr(1));
        psi_n = psi_n + exp(1i*n*t);
    end
end
if Neighbors ~= 0
    psi_n = psi_n / Neighbors;
end
end