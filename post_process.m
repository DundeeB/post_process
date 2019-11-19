function [] = post_process(lib, plot_flag, output_file_name, N_realizations)
display(['Post processing for library: ' lib]);
switch nargin
    case 4
        psi14 = psi_post_process_for_lib(lib, plot_flag, N_realizations);
%         [S45, Sm45, Sm_theta, k45, theta] = Bragg_post_process(lib, plot_flag, N_realizations);
        [ b, M ] = M_frustration_post_proccess_for_lib(lib, plot_flag, N_realizations);
    case 3
        psi14 = psi_post_process_for_lib(lib, plot_flag);
%         [S45, Sm45, Sm_theta, k45, theta] = Bragg_post_process(lib, plot_flag);
        [ b, M ] = M_frustration_post_proccess_for_lib(lib, plot_flag);
end
% save([lib '\' output_file_name],...
%     'psi14', 'S45', 'Sm45', 'Sm_theta', 'k45', 'theta','b','M');
save([lib '\' output_file_name],...
    'psi14', 'b','M');

% save([lib '\correct_psi_100_real'],'psi14');
%  save([lib '\M_fr_100_real'],'b','M');
end