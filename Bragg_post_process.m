tic
lib = 'simulation-results\N=900_h=0.7_rhoH=0.5';
k=[];
kz_Arr = 0:0.5:3*pi;
for kz=kz_Arr
    k = [k [0 0 kz]'];
end

S = calc_S_Bragg_for_lib(lib,k);
%%
figure;
plot(kz_Arr,abs(S(end,:)),'o');
set(gca,'FontSize',24);
xlabel('k_z');
ylabel('|S|');
title('Bragg scattering');grid on;
toc