function [S] = calc_Sm_Bragg_for_lib(lib, k, z0)
dir_struct = dir(lib);
homeDir = pwd;
addpath(homeDir);
cd(lib);
[~, Nk] = size(k);
N_converge = length(dir_struct);
S = zeros(N_converge + 1, Nk);
j = 1;
I = [];
for i=1:length(dir_struct)
    fold = dir_struct(i).name;
    try
        spheres = dlmread(fold);
        j = j+1;
        I(end+1) = i;
        S(j,:) = S(j-1,:) + Sm_Bragg(k, spheres, z0)';
    catch err
        disp([fold ' is not spheres data folder']);
    end
end
norm = (1:length(I))'.^-1*ones(1,Nk);
S = S(I,:).*norm;
cd(homeDir);
end