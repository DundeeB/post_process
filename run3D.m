tic;
h = 0.7
rho_H = 0.7
n_row = 30;
n_col = 30;
N = n_row * n_col

state.rad = 1;
state.H = (h+1)*2*state.rad;
state.cyclic_boundary = sqrt(1/rho_H)*2*state.rad*sqrt(n_row*n_col)*[1 1];

A = state.cyclic_boundary(2)*state.cyclic_boundary(1);
eta2D = N*pi*state.rad^2/A
eta3D = N*4*pi/3*state.rad^3/(A*state.H)
sim_name = ['N=' num2str(N) '_eta2D=' num2str(eta2D) '_eta3D=' ...
    num2str(eta3D), '_rho_H=' num2str(rho_H)]
title_name = ['N=' num2str(N) ', \eta_{2D}=' num2str(eta2D) ', \eta_{3D}=' ...
    num2str(eta3D), ', \rho_H=' num2str(rho_H)];
%%
addpath('.');
cd('simulation-results'); mkdir(sim_name); cd(sim_name);
%%
state.spheres = antiferro_rect_starting_cond3D([n_col n_row 1],[state.cyclic_boundary state.H],state.rad);
if ~legal_configuration(state,1)
    cd('../..');
    error('too many spheres');
end

N_real  = 1e4*N;
L = state.H;
f = 0.2;
step_size = f*(sqrt((state.cyclic_boundary(2)/n_row)^2+(state.cyclic_boundary(1)/n_col)^2)-2*state.rad);
N_save = 1e4;
N_start = 1e4;
%%
save('Input_parameters');
%%
q = 0;
for i=1:N_real
    t = rand*2*pi;
    if step_size > state.H
        phi = (2*rand-1)*(asin(state.H/step_size));
    else
        phi = rand*pi;
    end
    i_p = randi(N);
    [state, q_] = metropolis_step(state, i_p, step_size*[sin(phi)*cos(t) sin(phi)*sin(t) cos(phi)]);
    q = q + q_;
    if mod(i,N_real/10)==0
        disp([num2str(i/N_real*100) '%']);
    end
    
    if (mod(i,N_save) == 0 && i > N_start) || i==1 || i==N_real
        dlmwrite(num2str(i),state.spheres,'\t');
    end
end
%%
spheres = dlmread('1');
first_state = state;
first_state.spheres = spheres;
subplot(1,2,1);
plot_spheres(first_state); title(title_name);
subplot(1,2,2);
plot_spheres(state); title([num2str(i) ' step. Acceptance rate: ' ...
    num2str(100*q/i) '%, steps per sphere: ' num2str(q/N)]);
savefig('Starting_and_Final_configuration.fig')
% close all;
%%
cd('../../');
toc;