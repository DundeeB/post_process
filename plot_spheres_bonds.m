function [ output_args ] = plot_spheres_bonds( input_file, cutoff, H )
%PLOT_SPHERES_BONDS 
sp = dlmread(input_file);
x = sp(:,1); y = sp(:,2); z = sp(:,3);
TRI = delaunay(x,y);
hold all;
[N, ~] = size(sp);
[m, ~] = size(TRI);
bonds = zeros(N,N);
for i=1:N
    for j=1:N
        r1 = sp(i,:);
        r2 = sp(j,:);
        Dxy = norm(r1([1,2])-r2([1,2]));  % not cyclic because it looks better
        if Dxy <= cutoff
            I_plot = [i j];
            plot(x(I_plot),y(I_plot),'-b');
        end
    end
end
plot(x(z>H/2),y(z>H/2),'.Black','MarkerSize',20);
plot(x(z<=H/2),y(z<=H/2),'.m','MarkerSize',20);
end