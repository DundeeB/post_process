function [Nbins2D_avg, C2D, Nbins_avg, C] = ...
    calc_pair_correlation_for_lib(lib, m, n, Length, angle, isplot, N_realizations)

load_lib;

if nargin == 7 && N_realizations < N_sph_files
    N_max = N_realizations;
else
    N_max = N_sph_files;
    if nargin == 5
        isplot = false;
    end
end
N = length(state.spheres);
[xij, yij,~,~] = pair_correlation(state,m,n);

[Nbins2D,C2D] = hist3([xij(:) yij(:)], [N/2 N/2]);
[Xq2D,Yq2D] = meshgrid(C2D{1},C2D{2});
Nbins2D_sum = Nbins2D*0;

[Nbins,C] = plt_g_r(xij, yij, Length, angle, false);
Nbins_sum = Nbins*0;

reals = 0;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    state.spheres = spheres;
    [xij, yij] = pair_correlation(state,m,n);
    
    [Nbins2D_i,C2D_i] = hist3([xij(:) yij(:)], [N/2 N/2]);
    [X,Y] = meshgrid(C2D_i{1},C2D_i{2});
    Nbins2D_sum = Nbins2D_sum + interp2(X,Y, Nbins2D_i,Xq2D,Yq2D, 'spline',0);
    
    [Nbins_i,Centers_i] = plt_g_r(xij, yij, Length, angle, false);
    Nbins_sum = Nbins_sum + interp1(Centers_i, Nbins_i, C, 'spline',0);
    
    reals = reals + 1;
end
Nbins2D_avg = Nbins2D_sum/reals;
Nbins_avg = Nbins_sum/reals;
Nbins_avg = Nbins_avg/mean(Nbins_avg);
Nbins2D_avg = Nbins2D_sum/mean(Nbins2D_sum(:));
if isplot
    plot(C,Nbins_avg);
    plt_2D_bins(Nbins2D_avg,C2D);
    xlim([-Length Length]);ylim([-Length Length]);
    hold on;
    plot([0 Length*cos(angle)],[0 Length*sin(angle)],'-Black');
end
cd(homeDir);
end