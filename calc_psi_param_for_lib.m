function psi_global = calc_psi_param_for_lib(lib, m, n, N_realizations)
load_lib;
psi_global = [0];
if nargin == 3 || N_realizations > N_sph_files
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    [psi_local, ~] = psi_mn(m, n, spheres, state.cyclic_boundary);
    psi_global(end+1) = psi_global(end) + abs(mean(psi_local));
end
psi_global = psi_global(2:end)./[1:length(psi_global)-1];
cd(homeDir);
end