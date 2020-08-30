function [ bonds, sp] = plot_spheres_bonds( spheres, cutoff, H, cyclic_boundary )
hold all;
w = 20;
[bonds,~,sp] = Edges(spheres, w, cutoff, cyclic_boundary);
x = sp(:,1); y = sp(:,2); z = sp(:,3);
for i=1:length(bonds)
    e = bonds(i,:);
    if sum(z>H/2) == 0
        plot(x(e),y(e),'-m');
    elseif sum(z<=H/2) == 0
        plot(x(e),y(e),'-Black');
    else
        plot(x(e),y(e),'-b');
    end
end
plot(x(z>H/2),y(z>H/2),'.Black','MarkerSize',10);
plot(x(z<=H/2),y(z<=H/2),'.m','MarkerSize',10);
L = min(cyclic_boundary(1:2));
xlim([0 L]);
ylim([0 L]);
end