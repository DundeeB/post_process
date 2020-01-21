function [ b, M, N_sp ] = M_frustration_post_proccess_for_lib(lib, plot_flag, N_realizations)

load_lib;

b = [0];
N_sp = [0];
if nargin == 2 || N_realizations > N_sph_files
    N_max = N_sph_files;
else
    N_max = N_realizations;
end
j = 1;
H = state.H;
sig = state.rad*2;
for i=N_sph_files:-1:N_sph_files-N_max+1
    spheres = dlmread(files{i});
    N = length(state.spheres);
    A = state.cyclic_boundary(1)*state.cyclic_boundary(2);
    a = sqrt(A/N);
    [b_current,~,M, N_sp_current] = M_frustration(spheres, H, sig, 1.2*a,...
        state.cyclic_boundary);
    if ~isnan(b_current)
        b(end+1) = b(end) + b_current;
    end
    if ~isnan(N_sp_current)
        N_sp(end+1) = N_sp(end) + N_sp_current;
    end
end
b = b(2:end)./[1:length(b)-1];
N_sp = N_sp(2:end)./[1:length(N_sp)-1];
cd(homeDir);

if plot_flag
    I = 1:length(b);
    b_current = diff(b.*I);
    h = figure; 
    plot(I,b,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),b_current,'b');
    plot([0 I(end)],[b(end) b(end)],'--m','LineWidth',5);
    title('Convergence of b_1 = 1-M_{fr}/M'); ylabel('b_1');
    xlabel('# of realizations summed into b_1');
    set(gca,'FontSize',24); xlim([-10 I(end)]);
    legend('Average b_1','b_1 for current realization','Final b_1');
    savefig(h,[lib '\Convergence of b_1']);
    
    I = 1:length(N_sp);
    N_sp_current = diff(N_sp.*I);
    g = figure; 
    plot(I,N_sp,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),N_sp_current,'b');
    plot([0 I(end)],[N_sp(end) N_sp(end)],'--m','LineWidth',5);
    title('Convergence of N_{sp} = % connected spheres'); ylabel('N_{sp}');
    xlabel('# of realizations summed into N_{sp}');
    set(gca,'FontSize',24); xlim([-10 I(end)]);
    legend('Average N_{sp}','N_{sp} for current realization','Final N_{sp}');
    savefig(g,[lib '\Convergence of N_sp']);
end
end