function [outputArg1,outputArg2] = plot_spheres(state)
%PLOT_SPHERES Summary of this function goes here
%   Detailed explanation goes here
[x,y,z] = sphere;
spheres = state.spheres;
rad = state.rad;
H = state.H;
cyclic_boundary = state.cyclic_boundary;
[N,~] = size(spheres);
r = rad;
hold on; xlabel('X'); ylabel('Y'); zlabel('Z');set(gca,'FontSize',18);
for i=1:N
    x0 = spheres(i,1);
    y0 = spheres(i,2);
    z0 = spheres(i,3);
    surf(rad*x+x0,rad*y+y0,rad*z+z0);
end
zlim([0 state.H]);
axis equal;
shading interp;
xlim([-rad cyclic_boundary(1)+rad])
ylim([-rad cyclic_boundary(2)+rad])
end

