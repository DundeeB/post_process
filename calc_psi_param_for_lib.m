function psi_global = calc_psi_param_for_lib(m, n, lib, N_realizations)
addpath('../post_process/');
load_lib;
if nargin == 3 || N_realizations > N_sph_files
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
psi_global = zeros(N_max+1,1);
j = 1;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    [psi_local, ~] = psi_mn(m, n, spheres, state.cyclic_boundary);
    psi_global(j+1) = psi_global(j) + abs(mean(psi_local));
    j = j+1;
end
psi_global = psi_global(2:end)./(1:(length(psi_global)-1))';
cd(homeDir);
end