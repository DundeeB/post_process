function [] = calc_pair_correlation_for_lib(lib, m, n, N_realizations)

load_lib;

if nargin == 3 || N_realizations > N_sph_files
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
N = length(state.spheres);
spheres = dlmread(files{N_sph_files});
state.spheres = spheres;
[xij, yij] = pair_correlation(state,m,n);
[Nbins,C] = hist3([xij(:) yij(:)], [N/4 N/4]);
[Xq,Yq] = meshgrid(C{1},C{2});
N_bins_sum = Nbins*0;
reals = 0;

for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    state.spheres = spheres;
    [xij, yij] = pair_correlation(state,m,n);
    [Nbins_i,C_i] = hist3([xij(:) yij(:)], [N/4 N/4]);
    [X,Y] = meshgrid(C_i{1},C_i{2});
    N_bins_sum = N_bins_sum + interp2(X,Y, Nbins_i,Xq,Yq);
    reals = reals + 1;
end
Nbins_avg = N_bins_sum/reals;
plt_g_r_from_bins(Nbins_avg,C,20, pi/3);

cd(homeDir);
end