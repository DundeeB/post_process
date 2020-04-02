figure; hold all;

load from_ATLAS\N=3600_h=1.0_rhoH=0.93_AF_triangle_ECMC\'state 17992800.mat';
[counts, centers] = zz_correlation(state);
plot(centers/2,counts/(1*2/2),'--','LineWidth',3);

load from_ATLAS\N=3600_h=1.0_rhoH=0.85_AF_triangle_ECMC\'state 17992800.mat'
[counts, centers] = zz_correlation(state);
plot(centers/2,counts/(1*2/2),'--','LineWidth',3);

load from_ATLAS\N=3600_h=1.0_rhoH=0.55_AF_square_ECMC\'state 17992800.mat'
[counts, centers] = zz_correlation(state);
plot(centers/2,counts/(1*2/2),'--','LineWidth',3);

load ../simulation-results/N=3600_h=1_rhoH=0.1_AF_triangle/Input_parameters.mat
state.spheres = dlmread('../simulation-results/N=3600_h=1_rhoH=0.1_AF_triangle/20000000');
[counts, centers] = zz_correlation(state);
plot(centers/2,counts/(1*2/2),'--','LineWidth',3);

plot(centers/2, centers*0+0.25,'-k','LineWidth',2);
%%
legend('\rho_H=0.93','\rho_H=0.85','\rho_H=0.5','\rho_H=0.1',...
    'random zz limit 0.25','Location','SouthEast');
grid on; set(gca,'FontSize', 25);
xlabel('\Deltar/\sigma');
ylabel('<|zz|>/(h\sigma/2)');
xlim([0 15]); ylim([0 1]);