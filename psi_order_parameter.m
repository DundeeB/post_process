function [psi_mn] = psi_order_parameter(m, n, spheres, nearest_neighbors_cut_off, H, different_heights_cond)
%psi(m,n) is the order parameter 
[N_sp, ~] = size(spheres);
psi_mn = 0;
N_counted_sp = 0;
for a=1:N_sp
    [psi_n, Neighbors] = psi_n(a,n,spheres,nearest_neighbors_cut_off,H, ...
        different_heights_cond);
    if Neighbors ~= 0
        psi_mn = psi_mn + abs(psi_n)*exp(1i*m*angle(psi_n));
        N_counted_sp = N_counted_sp + 1;
    end
end
if N_counted_sp ~= 0
    psi_mn = psi_mn/N_counted_sp;
end
end

