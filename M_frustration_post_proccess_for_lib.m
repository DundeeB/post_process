function [ b ] = M_frustration_post_proccess_for_lib(lib, plot_flag, N_realizations)
switch nargin
    case 3
        b = calc_M_frustration_for_lib(lib, N_realizations);
    case 2
        b = calc_M_frustration_for_lib(lib);
end

I = 1:length(b);
psi_current = diff(b.*I);
h = figure; 
plot(I,b,'Black','LineWidth',3);
hold all; plot(I(1:end-1),psi_current,'b');
plot([0 I(end)],[b(end) b(end)],'--m','LineWidth',5);
title('Convergence of b_1 = 1-M_{fr}/M'); ylabel('b_1');
xlabel('# of realizations summed into \psi');
set(gca,'FontSize',24); xlim([-10 I(end)]);
legend('Average b_1','b_1 for current realization','Final b_1');
savefig(h,[lib '\Convergence of b_1']);
if ~plot_flag
    close(h);
end
end

