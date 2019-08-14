state.rad = 0.46;
state.H = 9.5;
state.cyclic_boundary = [9.5];
n_row = 10;
n_col = 10;
state.spheres = rect_starting_cond([n_col n_row],[state.cyclic_boundary state.H],state.rad);
N = n_row * n_col;
subplot(1,2,1);

A = state.H*state.cyclic_boundary(1);
eta = N*pi*state.rad^2/A;

plot_circles(state); title(['Starting conditions, N=' num2str(N) ', \eta=' num2str(eta)]);

N_real  = 1e6;
L = state.H;
f = 0.5;
step_size = f*(min(state.H/n_row, state.cyclic_boundary(1)/n_col)-2*state.rad);
%%
for i=1:N_real
    t = rand*2*pi;
    i_p = randi(N);
    state = metropolis_step(state, i_p, step_size*[cos(t) sin(t)]);
end
%%
subplot(1,2,2);
plot_circles(state); title([num2str(i) ' step']);