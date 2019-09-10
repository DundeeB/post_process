function [psi] = calc_psi_param_for_lib(lib, n, m, N_realizations)
dir_struct = dir(lib);
homeDir = pwd;
addpath(homeDir);
cd(lib);
load('Input_parameters');
psi = [0];
if nargin == 3
    N_max = length(dir_struct);
else
    N_max = N_realizations;
end
count = 0;
for i=length(dir_struct):-1:1
    fold = dir_struct(i).name;
    try
        spheres = dlmread(fold);
        psi(end+1) = psi(end) + psi_order_parameter(n, m, spheres, 1.2*2*state.rad);
        count = count + 1;
        if count >= N_max
            break;
        end
    catch err
        if strcmp(err.identifier,'MATLAB:textscan:handleErrorAndShowInfo')
            disp([fold ' is not spheres data folder']);
        else
            cd(homeDir);
            rethrow(err)
        end
    end
end
psi = psi(2:end)./[1:length(psi)-1];
cd(homeDir);
end

