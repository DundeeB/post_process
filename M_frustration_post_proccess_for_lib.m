function [ b1, M, N_sp ] = M_frustration_post_proccess_for_lib(n, lib, ...
    N_realizations, plot_flag)
load_lib;
if nargin < 3 || N_realizations > N_sph_files
    N_max = N_sph_files;
else
    N_max = N_realizations;
end

b1 = zeros(N_max+1,1);
N_sp = zeros(N_max+1,1);
j = 1;
for i=N_sph_files:-1:N_sph_files-N_max+1
    state.spheres = dlmread(files{i});
    [b_current,~,M, N_sp_current] = M_frustration(state,n);
    if isnan(b_current), b_current = 0; end
    if isnan(N_sp_current), N_sp_current = 0; end
    b1(j+1) = b1(j) + b_current;
    N_sp(j+1) = N_sp(j) + N_sp_current;
    j = j+1;
end
b1 = b1(2:end)./(1:(length(b1)-1))';
N_sp = N_sp(2:end)./(1:(length(N_sp)-1))';
cd(homeDir);

if nargin > 3 && plot_flag
    h = figure; 
    subplot(2,1,1);
    plt_order_parameter(2*b1-1,'2b_1-1');
    subplot(2,1,2);
    plt_order_parameter(N_sp,'N_{sp}');
    savefig(h,[lib '\Convergence of N_sp and b_1']);
end
end