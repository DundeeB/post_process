function [Sm_theta, theta, kxy] = fine_Sm_theta_for_folder(...
    lib, plot_flag, N_realizations)
%% simulation dir and parameters
load([lib '\Input_parameters']);  % loads state, h, rho_H
sim_name = ['N=' num2str(N) ' h=' num2str(h) ' \rho_H=' num2str(rho_H)];
sig = 2*state.rad;
a = sig/sqrt(rho_H*(h+1));
dk = pi/a;
%% S_m theta dependence
theta = pi/2*(0:1/40:5/4);  % len 60, contains pi/4 pi/2
kxy = (dk/cos(pi/4))*[cos(theta); sin(theta)];  % contains (pi pi)
z0 = sig*(1+h)/2;
%% calculate
tic;
switch nargin
    case 3
        Sm_theta = calc_Sm_Bragg_for_lib(lib,kxy, z0, N_realizations);
    case 2
        Sm_theta = calc_Sm_Bragg_for_lib(lib,kxy, z0);
end
Sm_theta_fin = abs(Sm_theta(end,:));
toc;
%% plot theta dependence
g = figure;

plot(theta/pi*180,Sm_theta_fin,'o--');

set(gca,'FontSize',24);
xlabel('\theta');
ylabel('|S|^2 at |k|=2^{1/2}\pi');
title(sim_name);
grid on; 
legend('<|z(k)|^2>','Location','NorthEast');
savefig(g,[lib '\Sm_theta_fine']);
%% plot theta convergence
e = figure;

hold all;plot(Sm_theta,'LineWidth',2);
% l = {};
% for i=1:length(theta)
%     l{end+1} = num2str(theta(i)*180/pi);
% end
% legend(l);

set(gca,'FontSize',24);
xlabel('# realizations sumed into S_m');
ylabel('<|z(k)|^2>');
title(sim_name);
grid on; 
savefig(e,[lib '\Convergence of Sm_theta_fine']);
%% close figures
if ~plot_flag
    close(g,e);
end
save([lib '\fine_Sm_output'],'Sm_theta', 'kxy', 'theta');
end