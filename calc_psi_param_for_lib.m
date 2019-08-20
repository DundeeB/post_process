function [psi] = calc_psi_param_for_lib(lib, n, m)
dir_struct = dir(lib);
homeDir = pwd;
addpath(homeDir);
cd(lib);
load('Input_parameters');
psi = [0];
for i=1:length(dir_struct)
    fold = dir_struct(i).name;
    try
        spheres = dlmread(fold);
        psi(end+1) = psi(end) + psi_order_parameter(n, m, spheres, 1.2*2*state.rad);
    catch err
        disp([fold ' is not spheres data folder']);
    end
end
psi = psi./[1:length(psi)];
cd(homeDir);
end

