files = sorted_sphere_files_from_lib(lib);
N_sph_files = length(files);
homeDir = pwd;
restoredefaultpath;
addpath(homeDir);
addpath('../post_process/');
cd(lib);
try
    load('Input_parameters');
catch err
    load('Input_parameters_from_python');
    state.rad = double(rad);
    state.cyclic_boundary = [Lx Ly];
    state.H = double(H);
    state.spheres = dlmread('Initial Conditions');
    save('Input_parameters','state');
end