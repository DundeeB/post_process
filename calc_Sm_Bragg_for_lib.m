<<<<<<< HEAD
function [S] = calc_Sm_Bragg_for_lib(lib, k, z0)
dir_struct = dir(lib);
homeDir = pwd;
addpath(homeDir);
cd(lib);
[~, Nk] = size(k);
N_converge = length(dir_struct);
S = zeros(N_converge + 1, Nk);
j = 1;
for i=1:length(dir_struct)
    fold = dir_struct(i).name;
    try
        spheres = dlmread(fold);
        j = j+1;
        S(j,:) = S(j-1,:) + Sm_Bragg(k, spheres, z0)';
    catch err
        disp([fold ' is not spheres data folder']);
        disp(err.message)
    end
end
S = S(1:j,:)./(1:j)';
cd(homeDir);
end
=======
function [S] = calc_Sm_Bragg_for_lib(lib, k, z0)
dir_struct = dir(lib);
homeDir = pwd;
addpath(homeDir);
cd(lib);
[~, Nk] = size(k);
N_converge = length(dir_struct);
S = zeros(N_converge + 1, Nk);
j = 1;
for i=1:length(dir_struct)
    fold = dir_struct(i).name;
    try
        spheres = dlmread(fold);
        j = j+1;
        S(j,:) = S(j-1,:) + Sm_Bragg(k, spheres, z0)';
    catch err
        disp([fold ' is not spheres data folder']);
        disp(err.message)
    end
end
S = S(1:j,:)./(1:j)';
cd(homeDir);
end