function [ b, M, N_sp ] = calc_M_frustration_for_lib(lib, N_realizations)
files = sorted_sphere_files_from_lib(lib);
N_sph_files = length(files);
homeDir = pwd;
addpath(homeDir);
cd(lib);
load('Input_parameters');
b = [0];
N_sp = [0];
if nargin == 1 || N_realizations > N_sph_files
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
j = 1;
H = state.H;
sig = state.rad*2;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    N = length(state.spheres);
    A = state.cyclic_boundary(1)*state.cyclic_boundary(2);
    a = sqrt(A/N);
    [b_current,~,M, N_sp_current] = M_frustration(spheres, H, sig, 1.2*a);
    if ~isnan(b_current)
        b(end+1) = b(end) + b_current;
    end
    if ~isnan(N_sp_current)
        N_sp(end+1) = N_sp(end) + N_sp_current;
    end
end
b = b(2:end)./[1:length(b)-1];
N_sp = N_sp(2:end)./[1:length(N_sp)-1];
cd(homeDir);
end