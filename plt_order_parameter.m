function [] = plt_order_parameter(psi, name)
psi_abs = abs(psi(:));
I = (1:length(psi_abs))';
psi_current = [psi_abs(1); diff(psi_abs.*I)];
hold all; 
plot(I,psi_abs,'Black','LineWidth',3);
plot(I,psi_current,'b');
plot([0 I(end)],[psi_abs(end) psi_abs(end)],'--m','LineWidth',5);
legend(['Average ' name],[name ' for current realization'],...
    ['Final ' name],'Location','NorthWest');
set(gca,'FontSize',24); 
xlim([-I(end)/100 I(end)]);
ylabel(name);
xlabel('# realizations');
end