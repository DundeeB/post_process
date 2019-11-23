function [ b, M, N_sp ] = M_frustration_post_proccess_for_lib(lib, plot_flag, N_realizations)
switch nargin
    case 3
        [b, M, N_sp] = calc_M_frustration_for_lib(lib, N_realizations);
    case 2
        [b, M, N_sp] = calc_M_frustration_for_lib(lib);
end

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