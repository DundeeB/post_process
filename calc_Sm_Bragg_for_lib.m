function [S] = calc_Sm_Bragg_for_lib(lib, k, z0, N_realizations)
dir_struct = dir(lib);
homeDir = pwd;
addpath(homeDir);
cd(lib);
[~, Nk] = size(k);
if nargin == 3
    N_max = length(dir_struct);
else
    N_max = N_realizations;
end
S = zeros(N_max + 1, Nk);
j = 1;
I = [];
for i=length(dir_struct):-1:1
    fold = dir_struct(i).name;
    try
        spheres = dlmread(fold);
        j = j+1;
        I(end+1) = j;
        S(j,:) = S(j-1,:) + Sm_Bragg(k, spheres, z0)';
        if j >= N_max + 1
            break
        end
    catch err
        if sum(strcmp(err.identifier,...
            {'MATLAB:textscan:handleErrorAndShowInfo',...
            'MATLAB:dlmread:FileNotOpened'}))
            disp([fold ' is not spheres data folder']);
        else
            cd(homeDir);
            rethrow(err)
        end
    end
end
norm = (1:length(I))'.^-1*ones(1,Nk);
S = S(I,:).*norm;
cd(homeDir);
end