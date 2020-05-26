close all; clc; clear all;

% lib = 'from_ATLAS\N=3600_h=1.0_rhoH=0.93_AF_triangle_ECMC';
% num = 17992800;
% leg = '\rho_H=0.93';

% lib = 'from_ATLAS\N=3600_h=1.0_rhoH=0.88_AF_square_ECMC';
% num = 12383280;
% leg = '\rho_H=0.88';

% lib = 'from_ATLAS\N=3600_h=1.0_rhoH=0.85_AF_triangle_ECMC';
% num = 17992800;
% leg = '\rho_H=0.85';

% lib = 'from_ATLAS\N=3600_h=1.0_rhoH=0.55_AF_square_ECMC';
% num = 17992800;
% leg = '\rho_H=0.55';

lib = 'from_ATLAS\N=3600_h=1.0_rhoH=0.5_AF_square_ECMC';
num = 17992800;
leg = '\rho_H=0.5';
%%
load([lib '\state ' num2str(num) '.mat']);
try
    load([lib '\psi23_E3_' num2str(num) '.mat']);
    E = E3; psi = psi23;
catch err
    [psi,E] = psi_mn(2,3,state,false);
end
E = bonds_from_directed_graph(E, state, 3, true);
hold on; quiver(state.spheres(:,1), state.spheres(:,2), real(psi), ...
    imag(psi));
L = max(state.cyclic_boundary(1:2));
axis equal;
xlim([0 L]);
ylim([0 L]);
disp([lib ' has psi=' num2str(abs(mean(psi)))]);
N_sp = M_frustration(state,3)
%%
winding = hist_winding(lib, num, psi, E);
%%
l = hist_charges(lib, num, E);
%%
p = p_q_analysis(lib, num, psi, E);
%%
for fig = 2:5
    figure(fig)
    legend(leg)
end