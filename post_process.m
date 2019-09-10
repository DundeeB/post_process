function [] = post_process(lib, plot_flag, output_file_name, N_realizations)
switch nargin
    case 4
        psi14 = psi_post_process_for_lib(lib, plot_flag, N_realizations);
        [S,Sm_45,Sm_theta] = Bragg_post_process(lib,plot_flag, N_realizations);
    case 3
        psi14 = psi_post_process_for_lib(lib, plot_flag);
        [S,Sm_45,Sm_theta] = Bragg_post_process(lib,plot_flag);
end
save([lib '\' output_file_name],'psi14','S','Sm_theta','Sm_45');
end