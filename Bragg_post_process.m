N = 900;
h = 0.7;
rhoH = 0.4118;
rad = 1; sig = 2*rad;
lib = ['simulation-results\N=' num2str(N) '_h=' num2str(h) '_rhoH=' num2str(rhoH)];
k=[];
kz_max = 2*pi/h;
kz_len = 15;
dk = kz_max/kz_len;
kz_Arr = dk:dk:kz_max;
%%
tic
for kz=kz_Arr
    k = [k [0 0 kz]'];
end

Sz = calc_S_Bragg_for_lib(lib,k);
Sz_fin = abs(Sz(end,:));
toc
%%
subplot(1,2,1);
plot(h*kz_Arr*sig/pi,Sz_fin,'o');
set(gca,'FontSize',24);
xlabel('(h\sigma/\pi)k_z');
ylabel('|S|');
title('Bragg scattering');grid on; 

i_m_1 = find(Sz_fin(2:end-1)>Sz_fin(3:end) & Sz_fin(2:end-1)>Sz_fin(1:end-2));
i = i_m_1 + 1;
kz = kz_Arr(i);
subplot(1,2,1);hold all;
plot(h*[kz kz]*sig/pi,minmax(Sz_fin),'--Black','LineWidth',3);

legend(['N=' num2str(N) ' h=' num2str(h) ...
    ' \rho_H=' num2str(rhoH)],'Local Maximum');
%%
k = [];
kx_nat = 2*pi/sig*sqrt(rhoH*(h+1));
kx_len = 15;
dk = kx_nat/kx_len;
kx_Arr = kx_nat*[0.9:0.01:1.1];
%%
tic
for kx=kx_Arr
    k = [k [kx 0 kz]'];
end

Sx = calc_S_Bragg_for_lib(lib,k);
Sx_fin = abs(Sx(end,:));
toc
%%
subplot(1,2,2);
plot(sig*kx_Arr/pi,Sx_fin,'o--');
set(gca,'FontSize',24);
xlabel('\sigmak_x/\pi');
ylabel('|S|');
title('Bragg scattering');grid on; legend(['N=' num2str(N) ' h=' num2str(h) ...
    ' \rho_H=' num2str(rhoH)]);
%%
tic
k = [];
for kx=kx_Arr
    k = [k [kx 0 0]'];
end

Sx_kz0 = calc_S_Bragg_for_lib(lib,k);
Sx_kz0_fin = abs(Sx_kz0(end,:));
%%
hold all;
plot(sig*kx_Arr/pi,Sx_kz0_fin,'o--');
toc
legend(['N=' num2str(N) ' h=' num2str(h) ...
    ' \rho_H=' num2str(rhoH)],'kz=0','Location','NorthWest');