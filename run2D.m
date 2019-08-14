state.rad = 0.4;
state.H = 9.5;
state.cyclic_boundary = [9.5];
n_row = 10;
n_col = 10;
state.spheres = rect_starting_cond([n_col n_row],[state.cyclic_boundary state.H]);
N = n_row * n_col;
subplot(1,2,1);
plot_circles(state); title('Starting conditions');
%%
N_real  = 5e4;
a = 2*state.rad;
L = state.H;
for i=1:N_real
    t = rand*2*pi;
    state = metropolis_step(state, randi(N), 0.1*[cos(t) sin(t)]);
end
subplot(1,2,2);
plot_circles(state); title([num2str(i) ' step']);