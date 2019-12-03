function [ bonds, sp] = plot_spheres_bonds( spheres, cutoff, H, cyclic_boundary )
hold all;
[bonds,~,sp] = Edges(spheres,cutoff,cyclic_boundary);
x = sp(:,1); y = sp(:,2); z = sp(:,3);
for i=1:length(bonds)
    e = bonds(i,:);
    plot(x(e),y(e),'-b');
end
plot(x(z>H/2),y(z>H/2),'.Black','MarkerSize',15);
plot(x(z<=H/2),y(z<=H/2),'.m','MarkerSize',15);
L = min(cyclic_boundary(1:2));
xlim([0 L]);
ylim([0 L]);
end