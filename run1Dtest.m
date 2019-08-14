state.rad = 0.5;
state.H = 12;
state.cyclic_boundary = [1.1];
N = 5;
state.spheres = [0.55*ones(N,1) linspace(state.rad, state.H-state.rad,N)'];
% plot_circles(state); title('Starting conditions');
%%
N_real  = 1e6;
a = 2*state.rad;
L = state.H;
x_interesting = [0.3 0.48 0.51 1 1.5 1.9 2.35 2.88 4 6 8 9.2 9.75 10.5 11 11.49 11.52 11.7];
x = zeros(length(x_interesting)*2-4,1);
for i=2:length(x_interesting)-1
    dx_p = x_interesting(i+1)-x_interesting(i);
    dx_m = x_interesting(i)-x_interesting(i-1);
    x(2*i-3) = x_interesting(i) - dx_m/4;
    x(2*i-2) = x_interesting(i) + dx_p/4;
end
rho = zeros(length(x)-1,1);
for i=1:N_real
%     t = rand*2*pi;
%     state = metropolis_step(state, randi(N), 0.2*[cos(t) sin(t)]);
    ds = (2*rand-1)*(L-N*a)/N;
    state = metropolis_step(state, randi(N), ds*[0 1]);
    v = state.spheres(:,2);
    for j=2:length(x)
        rho(j-1) = rho(j-1) + (sum(v>x(j-1) & v<x(j)))/(x(j)-x(j-1));
    end
end
% plot_circles(state); title([num2str(i) ' step']);
%%
figure;
x_ = 0.5*(x(1:end-1)+x(2:end));
RHO = rho/trapz(x_,rho);
plot(x_, RHO ,'o--');
xlabel('x'); ylabel('\rho');set(gca,'FontSize',24);grid on;xlim([0 L]);
title(['Metropolis 1D. N=' num2str(N) ', a=' num2str(a) ', L=' num2str(L)]);
ylim([-0.05 max(RHO)*1.1]);