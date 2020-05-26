function [Nbins2D_avg, C2D, Nbins_avg, Cp] = ...
    calc_positional_correlation_for_lib(lib, m, n, Length, angle, isplot, N_realizations)

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
[xij, yij,~,~] = positional_pairs(state, m, n, Length);

C = -Length:5*Length/N:Length;
Cp = C(C>0);
ctrs = {C C};
[Nbins2D,C2D] = hist3([xij(:) yij(:)], 'Ctrs', ctrs);
Nbins2D_sum = Nbins2D*0;

[Nbins,~] = plt_g_r(xij, yij, Length, angle, Cp, false);
Nbins_sum = Nbins*0;

reals = 0;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    state.spheres = spheres;
    [xij, yij] = positional_pairs(state,m,n);
    
    [Nbins2D_i,~] = hist3([xij(:) yij(:)], 'Ctrs', ctrs);
    Nbins2D_sum = Nbins2D_sum + Nbins2D_i;
    
    [Nbins_i,~] = plt_g_r(xij, yij, Length, angle, Cp, false);
    Nbins_sum = Nbins_sum + Nbins_i;
    
    reals = reals + 1;
end
Nbins2D_avg = Nbins2D_sum/reals;
Nbins_avg = Nbins_sum/reals;

Nbins2D_avg = Nbins2D_avg(2:end-1,2:end-1);
C2D = {C2D{1}(2:end-1) C2D{2}(2:end-1)};
Nbins_avg = Nbins_avg(1:end-1);
Cp = Cp(1:end-1);

Nbins_avg = Nbins_avg/mean(Nbins_avg);
Nbins2D_avg = Nbins2D_avg/mean(Nbins2D_avg(:));

if isplot
    plot(Cp,Nbins_avg,'.-','MarkerSize',24);
    set(gca,'FontSize',20);
    xlabel('$$\sqrt{\Delta x^2+\Delta y^2}  (\sigma =2)$$',...
        'interpreter','latex');
    ylabel('g(r)');
    grid on;
    
    plt_2D_bins(Nbins2D_avg,C2D);
    xlim([-Length Length]);ylim([-Length Length]);
    hold on;
    plot([0 Length*cos(angle)],[0 Length*sin(angle)],'-Black','LineWidth',2);
    h = colorbar;
    set(get(h,'title'),'string','g(r)');
    
end
cd(homeDir);
end