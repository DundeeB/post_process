function [] = plot_circles(state)
spheres = state.spheres;
rad = state.rad;
H = state.H;
cyclic_boundary = state.cyclic_boundary;
[N,~] = size(spheres);
r = rad;
hold on; axis equal; xlabel('X'); ylabel('Y'); set(gca,'FontSize',24);
for i=1:N
    x0 = spheres(i,1);
    y0 = spheres(i,2);
    plot(x0 + r*cos(linspace(0,2*pi)),y0 + r*sin(linspace(0,2*pi)),'-b');
end
xmin = 0; xmax = cyclic_boundary(1);
ymin = 0;
if length(cyclic_boundary) > 1
    ymax = cyclic_boundary(2);
    y_style = '--g';
else
    ymax = H;
    y_style = '-r';
end
plot([xmin xmax],[0 0],y_style);
plot([xmin xmax],[ymax ymax],y_style);
plot([xmin xmin],[0 ymax],'--g');
plot([xmax xmax],[0 ymax],'--g');
xlim([xmin-(xmax-xmin)/10 xmax+(xmax-xmin)/10]);
ylim([ymin-(ymax-ymin)/10 ymax+(ymax-ymin)/10]);
end

