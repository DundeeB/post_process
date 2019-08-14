state.rad = 1;
state.H = 1.7*2*state.rad;
state.cyclic_boundary = 8.5/0.46*state.rad*[1 1];
n_row = 10;
n_col = 10;

state.spheres = antiferro_rect_starting_cond3D([n_col n_row 1],[state.cyclic_boundary state.H],state.rad);
if ~legal_configuration(state,1)
    error('too many spheres');
end

N = n_row * n_col;
subplot(1,2,1);

A = state.cyclic_boundary(2)*state.cyclic_boundary(1);
eta2D = N*pi*state.rad^2/A;
eta3D = N*4*pi/3*state.rad^3/(A*state.H);
rho_H = N*(2*state.rad)^3/(A*state.H);

plot_spheres(state); title(['Starting conditions, N=' num2str(N) ...
    ', \eta_{2D}=' num2str(eta2D) ', \eta_{3D}=' num2str(eta3D), ...
    ', \rho_H=' num2str(rho_H)]);

N_real  = 1e6;
L = state.H;
f = 0.2;
step_size = f*(sqrt((state.cyclic_boundary(2)/n_row)^2+(state.cyclic_boundary(1)/n_col)^2)-2*state.rad);
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
end
%%
subplot(1,2,2);
plot_spheres(state); title([num2str(i) ' step. Acceptance rate: ' num2str(100*q/i) '%']);