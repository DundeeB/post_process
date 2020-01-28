function [] = plot_spheres(state)
figure;
[x,y,z] = sphere(12);
spheres = state.spheres;
rad = state.rad;
cyclic_boundary = state.cyclic_boundary;
[N,~] = size(spheres);
hold on; xlabel('X'); ylabel('Y'); zlabel('Z');set(gca,'FontSize',14);
for i=1:N
    x0 = spheres(i,1);
    y0 = spheres(i,2);
    z0 = spheres(i,3);
    surf(rad*x+x0,rad*y+y0,rad*z+z0);
end
zlim([0 state.H]);
axis equal;
shading interp;
xlim([0 cyclic_boundary(1)])
ylim([0 cyclic_boundary(2)])
end

