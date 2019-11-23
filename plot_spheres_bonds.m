function [ output_args ] = plot_spheres_bonds( input_file, cutoff, H )
%PLOT_SPHERES_BONDS 
sp = dlmread(input_file);
x = sp(:,1); y = sp(:,2); z = sp(:,3);
TRI = delaunay(x,y);
figure;
hold all;
[N, ~] = size(sp);
[m, ~] = size(TRI);
bonds = zeros(N,N);
for i=1:m
    I = TRI(i,:);
    I = [I I(1)];  % add bond I(3) I(1)
    for j=1:3
        r1 = sp(I(j),:);
        r2 = sp(I(j+1),:);
        Dxy = norm(r1([1,2])-r2([1,2]));
        if Dxy <= cutoff
            I_plot = [I(j) I(j+1)];
            plot(x(I_plot),y(I_plot),'-b');
        end
    end
end
plot(x(z>H/2),y(z>H/2),'.Black','MarkerSize',20);
plot(x(z<=H/2),y(z<=H/2),'.m','MarkerSize',20);
end