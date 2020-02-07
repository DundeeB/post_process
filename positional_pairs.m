function [xij, yij,rs,t] = positional_pairs(state,m,n)
spheres = state.spheres/state.rad;
Lx = state.cyclic_boundary(1);
Ly = state.cyclic_boundary(2);
t = -1/(m*n)*angle(mean(psi_mn(m, n, spheres, state.cyclic_boundary)));
x0 = spheres(1,1);
y0 = spheres(1,2);
x = (spheres(:,1)-x0)*cos(t)-(spheres(:,2)-y0)*sin(t);
y = (spheres(:,1)-x0)*sin(t)+(spheres(:,2)-y0)*cos(t);
xij = zeros(length(x),length(x));
yij = zeros(length(x),length(x));
for i=1:length(x)
    for j=1:length(x)
        dx = x(i) - x(j); 
        vx = [dx, (dx+Lx), (dx-Lx)];
        [~,k] = min(abs(vx));
        xij(i,j) = vx(k);

        dy = y(i) - y(j); 
        vy = [dy, (dy+Ly), (dy-Ly)];
        [~,k] = min(abs(vy));
        yij(i,j) = vy(k);
    end
end
rs = sqrt(xij(:).^2+yij(:).^2);
end