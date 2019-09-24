function [] = post_process(lib, plot_flag, output_file_name, N_realizations)
display(['Post processing for library: ' lib]);
switch nargin
    case 4
        psi14 = psi_post_process_for_lib(lib, plot_flag, N_realizations);
%         [S45, Sm45, Sm_theta, k45, theta] = Bragg_post_process(lib,plot_flag, N_realizations);
    case 3
        psi14 = psi_post_process_for_lib(lib, plot_flag);
%         [S45, Sm45, Sm_theta, k45, theta] = Bragg_post_process(lib,plot_flag);
end
% save([lib '\' output_file_name],'psi14','S45', 'Sm45', 'Sm_theta', 'k45', 'theta');
save([lib '\correct_psi_100_real'],'psi14');
end