function [psi] = calc_psi_param_for_lib(lib, n, m, N_realizations)
files = sorted_sphere_files_from_lib(lib);
N_sph_files = length(files);
homeDir = pwd;
addpath(homeDir);
cd(lib);
load('Input_parameters');
psi = [0];
if nargin == 3
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
j = 1;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    psi(end+1) = psi(end) + psi_order_parameter(n, m, spheres, 1.2*2*state.rad);
end
psi = psi(2:end)./[1:length(psi)-1];
cd(homeDir);
end

