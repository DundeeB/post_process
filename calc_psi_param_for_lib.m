function [psi, psi_up, psi_down] = calc_psi_param_for_lib(lib, m, n, seperate_up_down, N_realizations)
load_lib;
psi = [0];
psi_up = [0];
psi_down = [0];
if nargin == 4 || N_realizations > N_sph_files
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
j = 1;
H = state.H;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    psi(end+1) = psi(end) + abs(psi_order_parameter(m, n, spheres, 1.1*2*state.rad,H, true));
    if seperate_up_down
        z = spheres(:,3);
        s_up = spheres(z>H/2,:);
        s_down = spheres(z<=H/2,:);
        psi_up(end+1) = psi(end) + abs(psi_order_parameter(m, n, s_up, 2*1.1*2*state.rad,H, false));
        psi_down(end+1) = psi(end) + abs(psi_order_parameter(m, n, s_down, 2*1.1*2*state.rad,H, false));
    end
end
psi = psi(2:end)./[1:length(psi)-1];
if seperate_up_down
    psi_up = psi_up(2:end)./[1:length(psi_up)-1];
    psi_down = psi_down(2:end)./[1:length(psi_down)-1];
end
cd(homeDir);
end