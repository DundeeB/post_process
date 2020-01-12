function [psi14, psi23, psi16, psi16_up, psi16_down] = psi_post_process_for_lib(lib, plot_flag, N_realizations)
switch nargin
    case 3
        psi14 = calc_psi_param_for_lib(lib, 1, 4, false, N_realizations);
        psi23 = calc_psi_param_for_lib(lib, 2, 3, false, N_realizations);
        [psi16,psi16_up, psi16_down] = calc_psi_param_for_lib(lib, 1, 6, true, N_realizations);
    case 2
        psi14 = calc_psi_param_for_lib(lib, 1, 4, false);
        psi23 = calc_psi_param_for_lib(lib, 2, 3, false);
        [psi16,psi16_up, psi16_down] = calc_psi_param_for_lib(lib, 1, 6, true);
end

if plot_flag
    h = figure; 
    title('Convergence of \psi'); 
    
    subplot(2,2,1);
    psi_abs = abs(psi14);
    I = 1:length(psi_abs);
    psi_current = diff(psi_abs.*I);    
    plot(I,psi_abs,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),psi_current,'b');
    plot([0 I(end)],[psi_abs(end) psi_abs(end)],'--m','LineWidth',5);
    ylabel('|\psi_{14}|');
    legend('Average \psi_{14}','\psi_{14} for current realization',...
        'Final \psi_{14}','Location','NorthWest');
    set(gca,'FontSize',24); 
    xlim([-10 I(end)]);
    
    subplot(2,2,3);
    psi_abs = abs(psi23);
    I = 1:length(psi_abs);
    psi_current = diff(psi_abs.*I);
    plot(I,psi_abs,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),psi_current,'b');
    plot([0 I(end)],[psi_abs(end) psi_abs(end)],'--m','LineWidth',5);
    ylabel('|\psi_{23}|');
    xlabel('# of realizations summed into \psi');
    legend('Average \psi_{23}','\psi_{23} for current realization',...
        'Final \psi_{23}','Location','NorthWest');
    set(gca,'FontSize',24); 
    xlim([-10 I(end)]);
    
    subplot(2,2,2);
    psi_abs = abs(psi16_up);
    I = 1:length(psi_abs);
    psi_current = diff(psi_abs.*I);    
    plot(I,psi_abs,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),psi_current,'b');
    plot([0 I(end)],[psi_abs(end) psi_abs(end)],'--m','LineWidth',5);
    ylabel('|\psi_{16}^{up}|');
    legend('Average \psi_{16}^{up}','\psi_{16}^{up} for current realization',...
        'Final \psi_{16}^{up}','Location','NorthWest');
    set(gca,'FontSize',24); 
    xlim([-10 I(end)]);
    
    subplot(2,2,4);
    psi_abs = abs(psi16_down);
    I = 1:length(psi_abs);
    psi_current = diff(psi_abs.*I);
    plot(I,psi_abs,'Black','LineWidth',3);
    hold all; plot(I(1:end-1),psi_current,'b');
    plot([0 I(end)],[psi_abs(end) psi_abs(end)],'--m','LineWidth',5);
    ylabel('|\psi_{16}^{down}|');
    xlabel('# of realizations summed into \psi');
    legend('Average \psi_{16}^{down}','\psi_{16}^{down} for current realization',...
        'Final \psi_{16}^{down}','Location','NorthWest');
    set(gca,'FontSize',24); 
    xlim([-10 I(end)]);
    
    savefig(h,[lib '\Convergence of psi']);
end
end