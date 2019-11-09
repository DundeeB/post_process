function [ b ] = calc_M_frustration_for_lib(lib, N_realizations)
files = sorted_sphere_files_from_lib(lib);
N_sph_files = length(files);
homeDir = pwd;
addpath(homeDir);
cd(lib);
load('Input_parameters');
b = [1];
if nargin == 1
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
j = 1;
H = state.H;
sig = state.rad*2;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    [b_current,~,~] = M_frustration(spheres, 1.2*sig, H, sig);
    b(end+1) = b(end) + b_current;
end
b = b(2:end)./[1:length(b)-1];
cd(homeDir);
end