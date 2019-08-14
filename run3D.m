state.rad = 0.5;
state.H = 1.5;
state.cyclic_boundary = [10 10];
n_row = 9;
n_col = 9;
state.spheres = rect_starting_cond([n_col n_row 1],[state.cyclic_boundary state.H],state.rad);
N = n_row * n_col;
subplot(1,2,1);

A = state.cyclic_boundary(2)*state.cyclic_boundary(1);
eta2D = N*pi*state.rad^2/A;
eta3D = N*4*pi/3*state.rad^3/(A*state.H);

plot_spheres(state); title(['Starting conditions, N=' num2str(N) ...
    ', \eta_{2D}=' num2str(eta2D) ', \eta_{3D}=' num2str(eta3D)]);

N_real  = 1e4;
L = state.H;
f = 0.5;
step_size = f*(min(state.cyclic_boundary(2)/n_row, state.cyclic_boundary(1)/n_col)-2*state.rad);
%%
for i=1:N_real
    t = rand*2*pi;
    if step_size > state.H
        phi = (2*rand-1)*(asin(state.H/step_size));
    else
        phi = rand*pi;
    end
    i_p = randi(N);
    state = metropolis_step(state, i_p, step_size*[sin(phi)*cos(t) sin(phi)*sin(t) cos(phi)]);
end
%%
subplot(1,2,2);
plot_spheres(state); title([num2str(i) ' step']);