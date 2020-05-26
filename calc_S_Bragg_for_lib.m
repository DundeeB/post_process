function [S] = calc_S_Bragg_for_lib(k, lib, N_realizations)
files = sorted_sphere_files_from_lib(lib);
N_sph_files = length(files);
homeDir = pwd;
addpath(homeDir);
cd(lib);
[~, Nk] = size(k);
if nargin == 2
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
S = zeros(N_max + 1, Nk);
j = 1;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    S(j+1,:) = S(j,:) + S_Bragg(k, spheres)';
    j = j + 1;
end
norm = (1:N_max)'.^-1*ones(1,Nk);
S = S(2:end,:).*norm;
cd(homeDir);
end