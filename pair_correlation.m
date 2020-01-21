function [xij, yij,rs,t] = pair_correlation(state,m,n)
spheres = state.spheres/state.rad;
x_rotated = spheres(:,1); y_rotated = spheres(:,2);
t = -angle(psi_order_parameter(m,n,spheres,1.2*2*state.rad,state.H,false))/(m*n);
x = x_rotated*cos(t)-y_rotated*sin(t);
y = x_rotated*sin(t)+y_rotated*cos(t);
addpath('../3D Metropolis Monte Carlo/');
xij = zeros(length(x),length(x));
yij = zeros(length(x),length(x));
for i=1:length(x)
    for j=1:length(x)
        dx = x(i) - x(j); Lx = state.cyclic_boundary(1);
        vx = [dx, (dx+Lx), (dx-Lx)];
        [~,k] = min(abs(vx));
        xij(i,j) = vx(k);

        dy = y(i) - y(j); Ly = state.cyclic_boundary(2);
        vy = [dy, (dy+Ly), (dy-Ly)];
        [~,k] = min(abs(vy));
        yij(i,j) = vy(k);
    end
end
rs = sqrt(xij(:).^2+yij(:).^2);
end