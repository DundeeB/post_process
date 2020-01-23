function [psimn_avg] = psi_order_parameter(m, n, spheres, nearest_neighbors_cut_off, H, different_heights_cond)
%psi(m,n) 
% n = #number of neighbers in order phase.  
% m = #symmetry/n
% for example, in the honeycomb lattice we have 3 neighbors and the
% symmetry is 6, so n=2 and m=3.
[N_sp, ~] = size(spheres);
psimn_sum = 0;
N_counted_sp = 0;
for a=1:N_sp
    [psimn_a, Neighbors] = psimn_sum(a, m, n, spheres,nearest_neighbors_cut_off, H, ...
        different_heights_cond);
    if Neighbors ~= 0
        psimn_sum = psimn_sum + psimn_a;
        N_counted_sp = N_counted_sp + 1;
    end
end
if N_counted_sp ~= 0
    psimn_avg = psimn_sum/N_counted_sp;
end
end

