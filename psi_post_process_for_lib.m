function [psi14, psi23] = psi_post_process_for_lib(lib, plot_flag, N_realizations)
switch nargin
    case 3
        psi14 = calc_psi_param_for_lib(lib, 1, 4, N_realizations);
        psi23 = calc_psi_param_for_lib(lib, 2, 3, N_realizations);
    case 2
        psi14 = calc_psi_param_for_lib(lib, 1, 4);
        psi23 = calc_psi_param_for_lib(lib, 2, 3);
end

if plot_flag
    h = figure; 
    title('Convergence of \psi'); 
    
    subplot(2,1,1);
    psi_abs = abs(psi14);
    I = 1:length(psi_abs);
    psi_current = diff(psi_abs.*I);    
    plot(I,psi_abs,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),psi_current,'b');
    plot([0 I(end)],[psi_abs(end) psi_abs(end)],'--m','LineWidth',5);
    ylabel('|\psi_{14}|');
    legend('Average \psi_{14}','\psi_{14} for current realization','Final \psi_{14}');
    set(gca,'FontSize',24); 
    
    subplot(2,1,2);
    psi_abs = abs(psi23);
    I = 1:length(psi_abs);
    psi_current = diff(psi_abs.*I);
    plot(I,psi_abs,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),psi_current,'b');
    plot([0 I(end)],[psi_abs(end) psi_abs(end)],'--m','LineWidth',5);
    ylabel('|\psi_{23}|');
    xlabel('# of realizations summed into \psi');
    legend('Average \psi_{23}','\psi_{23} for current realization','Final \psi_{23}');
    set(gca,'FontSize',24); 
    
    xlim([-10 I(end)]);
    savefig(h,[lib '\Convergence of psi']);
end
end

