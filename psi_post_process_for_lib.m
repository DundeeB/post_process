function [psi16, psi14, psi23] = psi_post_process_for_lib(lib, ...
    N_realizations, plot_flag)
if nargin>1
    psi16 = calc_psi_param_for_lib(1, 6, lib, N_realizations);
    psi14 = calc_psi_param_for_lib(1, 4, lib, N_realizations);
    psi23 = calc_psi_param_for_lib(2, 3, lib, N_realizations);
else
    psi16 = calc_psi_param_for_lib(1, 6, lib);
    psi14 = calc_psi_param_for_lib(1, 4, lib);
    psi23 = calc_psi_param_for_lib(2, 3, lib);
end

if nargin>2 && plot_flag
    h = figure; 
    subplot(2,2,1);
    plt_order_parameter(psi16, '|\psi_{16}|');
    subplot(2,2,2);
    plt_order_parameter(psi14, '|\psi_{14}|');
    subplot(2,2,3);
    plt_order_parameter(psi23, '|\psi_{23}|');
    savefig(h,[lib '\Convergence of psi']);
end
end