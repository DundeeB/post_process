function [psipsi_avg, psipsi_avg2D, ctrs] = calc_orientational_correlation_for_lib(...
    lib, m, n, Length, angle, Nbins, isplot, N_realizations)

load_lib;
N = length(state.spheres);
if nargin == 8 && N_realizations < N_sph_files
    N_max = N_realizations;
end
if nargin < 8
    N_max = N_sph_files;
end
if nargin < 7
    isplot = false;
end
if nargin < 6
    Nbins = N/9;
end

C = -Length:Length/Nbins:Length;
ctrs = {C C};
counts_over_reals2D = C'*C*0;
psipsi_sum_over_reals2D = counts_over_reals2D*0;

Cp = C(C>0);
psipsi_sum_over_reals = Cp*0;
counts_over_reals = Cp*0;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    state.spheres = spheres;
    [psipsi, xij, yij] = orientational_pairs(state, m, n);
    [counts2D, psipsi_sum2D] = histXYZ(xij, yij, psipsi, ctrs);
    psipsi_sum_over_reals2D = psipsi_sum_over_reals2D + psipsi_sum2D;
    counts_over_reals2D = counts_over_reals2D + counts2D;
    
    [psipsi_i, counts_i] = plt_psi_r(counts2D, psipsi_sum2D, ctrs, angle, Cp);
    psipsi_sum_over_reals = psipsi_sum_over_reals + psipsi_i;
    counts_over_reals = counts_over_reals + counts_i;
end
I = counts_over_reals2D~=0;
psipsi_avg2D = psipsi_sum_over_reals2D*0;
psipsi_avg2D(I) = psipsi_sum_over_reals2D(I)./counts_over_reals2D(I);

I = counts_over_reals~=0;
psipsi_avg = psipsi_sum_over_reals*0;
psipsi_avg(I) = psipsi_sum_over_reals(I)./counts_over_reals(I);

if isplot
    plot(Cp,abs(psipsi_avg),'o--');
    set(gca,'FontSize',20)
    xlabel('$$\sqrt{\Delta x^2+\Delta y^2}  (\sigma =2)$$',...
        'interpreter','latex')
    ylabel('|<\psi\psi*>|');
    grid on;
    
    plt_2D_bins(abs(psipsi_avg2D), ctrs);
    xlim([-Length Length]);ylim([-Length Length]);
    hold on;
    plot([0 Length*cos(angle)],[0 Length*sin(angle)],'-Black','LineWidth',2);
    h = colorbar;
    set(get(h,'title'),'string','$$|<\psi\psi^*>|$$',...
        'Interpreter','latex','fontsize',24)
end
cd(homeDir);
end