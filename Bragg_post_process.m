%% simulation dir and parameters
N = 3600;
h = 0.6;
rhoH = 0.4;
rad = 1; sig = 2*rad;
a = sig/sqrt(rhoH*(h+1));
lib = ['simulation-results\N=' num2str(N) '_h=' num2str(h) '_rhoH=' num2str(rhoH)];
%% kx Bragg picks at 2pi
k=[];
kx_max = 3.5*pi/a;
kx_len = 3;
dk = kx_max/kx_len;
kx = dk:dk:kx_max;
%%
tic
for kx_=kx
    k = [k [kx_ kx_ 0]'];
end

S_convergence = calc_S_Bragg_for_lib(lib,k);
S = S_convergence(end,:);
toc
%% S magnetic
tic
kxy = k(1:2,:);
z0 = sig*(1+h)/2;
Sm_convergence = calc_Sm_Bragg_for_lib(lib,kxy, z0);
Sm = abs(Sm_convergence(end,:));
toc
%% plot all
figure;

plot(kx*a/pi,S,'o--');
hold all;
plot(2+0*minmax(S),[0 max(S)],'--Black','LineWidth',3);
plot(kx*a/pi,Sm,'o--');
plot(1+0*minmax(S),[0 max(Sm)],'--m','LineWidth',3);

set(gca,'FontSize',24);
xlabel('k [\pi/a]');
ylabel('|S|^2');
title(['Bragg scattering, N=' num2str(N) ' h=' num2str(h) ...
    ' \rho_H=' num2str(rhoH)]);grid on; 
legend('<|S|^2>=<|1/N\Sigma_ie^{ikr}|^2>','(2\pi, 2\pi)',...
    '<|z(k)|^2>=<|1/N\Sigma_iz_ie^{ikr}|^2>','(\pi, \pi)',...
    'Location','NorthWest');

%% S magnetic pi pi pick dependence on theta
tic
theta = 0:(2*pi/16):2*pi;
rad = 1;
a = 2*rad/sqrt(rhoH*(h+1));
kxy = 2/sqrt(2)*pi/a*[cos(theta); sin(theta)];
z0 = sig*(1+h)/2;
%% calculate
Sm_convergence = calc_Sm_Bragg_for_lib(lib,kxy, z0);
Sm = abs(Sm_convergence(end,:));
toc
%% plot theta dependence
figure;

plot(theta/pi*180,Sm,'o--'); xlim([0 360]);ylim([0 max(Sm)]);

set(gca,'FontSize',24);
xlabel('\theta');
ylabel('|S|^2');
title(['Bragg scattering \theta dependence, N=' num2str(N) ' h=' num2str(h) ...
    ' \rho_H=' num2str(rhoH)]);grid on; 
legend('<|z(k)|^2>=<|1/N\Sigma_iz_ie^{ikr}|^2> at |k|=2^{1/2}\pi',...
    'Location','NorthWest');