function [S45, Sm45, Sm_theta] = Bragg_post_process(...
    lib, plot_flag, N_realizations)
%% simulation dir and parameters
load([lib '\Input_parameters']);  % loads state, h, rho_H
sim_name = ['N=' num2str(N) ' h=' num2str(h) ' \rho_H=' num2str(rho_H)];
sig = 2*state.rad;
a = sig/sqrt(rho_H*(h+1));
%% k45 -  Bragg picks at 2pi
k45 = [];
dk = pi/a;
kx = dk*(0.5:0.5:2.5);  % len 5, contains pi pi and 2pi 2pi
for kx_=kx
    k45 = [k45 [kx_ kx_ 0]'];
end
kxy = k45(1:2,:);
z0 = sig*(1+h)/2;
%% S 45
tic
switch nargin
    case 3
        S45 = calc_S_Bragg_for_lib(lib,k45, N_realizations);
    case 2
        S45 = calc_S_Bragg_for_lib(lib,k45);
end
S45fin = S45(end,:);
toc
%% S_m 45
tic
switch nargin
    case 3
        Sm45 = calc_Sm_Bragg_for_lib(lib,kxy, z0, N_realizations);
    case 2
        Sm45 = calc_Sm_Bragg_for_lib(lib,kxy, z0);
end
Sm45fin = abs(Sm45(end,:));
toc

%% plot S45 and Sm45
f = figure;
plot(kx/dk,S45fin,'o--');
hold all;
plot(2+0*minmax(S45fin),[0 max(S45fin)],'--Black','LineWidth',3);
plot(kx/dk,Sm45fin,'o--');
plot(1+0*minmax(Sm45fin),[0 max(Sm45fin)],'--m','LineWidth',3);

set(gca,'FontSize',24);
xlabel('k [\pi/a]');
ylabel('Order Parameter');
title(sim_name);
grid on; 
legend('<|S|^2>','(2\pi, 2\pi)','<|z(k)|^2>','(\pi, \pi)','Location','North');
savefig(f,[lib '\S45_Sm45_k']);
%% S_m theta dependence
theta = pi/2*(0:1/4:5/4);  % len 6, contains pi/4 pi/2
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
savefig(g,[lib '\Sm_theta']);
%% plot theta convergence
e = figure;

hold all;plot(Sm_theta,'LineWidth',2);
l = {};
for i=1:length(theta)
    l{end+1} = num2str(theta(i)*180/pi);
end
legend(l);

set(gca,'FontSize',24);
xlabel('# realizations sumed into S_m');
ylabel('<|z(k)|^2>');
title(sim_name);
grid on; 
savefig(e,[lib '\Convergence of Sm_theta']);
%% close figures
if ~plot_flag
    close(f,g,e);
end
end