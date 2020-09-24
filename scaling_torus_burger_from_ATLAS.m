function [Bs] = scaling_torus_burger_from_ATLAS(sim_path, plot_avg)
% sim_path = 'from_ATLAS2.0\N=8100_h=0.8_rhoH=0.77_AF_triangle_ECMC\';
% sim_path = 'from_ATLAS2.0\N=8100_h=0.8_rhoH=0.81_AF_triangle_ECMC\';
% visualize_burger(sim_path);
[r_b, sp, boundaries] = visualize_burger(sim_path, false);
r = r_b(:,1:2);
b = r_b(:,3:4);

load([sim_path '/Input_parameters_from_python.mat']);
as = 0:Ly/length(b):Ly;
Bs = zeros(length(as),2);
Bs_ = zeros(length(as),1);
for i=1:length(as)
    a=as(i);
    Bs(i,:) = sum(b(r(:,2)<a,:));
    Bs_(i) = norm(Bs(i,:));
end
%%
figure;hold all;
N = rho_H/8*(Lx*Ly*H);
a = sqrt(Lx*Ly/N);
plot(as,Bs_/a,'.-b','DisplayName',...
    'scaling  for $0<y(dislocation)<a$','LineWidth',2,'MarkerSize',20);
grid on; hold all;
xlabel('a');
ylabel('|sum(burger)|/(lattice constant)');
set(gca,'FontSize',20);
legend('interpreter','latex');
xlim([0 Ly]);
if nargin>1 && plot_avg
    plot(as,movmean(Bs_/a,length(Bs)/3),'-k','LineWidth',4,'DisplayName','average');
end
end