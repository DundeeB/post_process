function [B, R] = collapse_burger(sim_path, a, is_plot, plot_grid)
[burg, sp, boundaries] = visualize_burger(sim_path, is_plot);
r = burg(:,1:2);
b = burg(:,3:4);
Lx = boundaries(1);
Ly = boundaries(2);

x_c = (0:a:(ceil(Lx/a))*a)+a/2;
y_c = (0:a:(ceil(Ly/a))*a)+a/2;
B_grid = zeros(length(x_c),length(y_c),2);
for i=1:length(r)
    ix = ceil(r(i, 1)/a);
    iy = ceil(r(i, 2)/a);
    B_grid(ix,iy,:) = reshape(B_grid(ix,iy,:),[1 2]) + b(i,:);
end
Bx = [];
Rx = [];
By = [];
Ry = [];
for ix = 1:length(x_c)
    for iy = 1:length(y_c)
        if sum(abs((B_grid(ix,iy,:))))>1e-4
            Bx(end+1) = B_grid(ix,iy,1);
            By(end+1) = B_grid(ix,iy,2);
%             Rx(end+1) = R_grid(ix,iy,1);
%             Ry(end+1) = R_grid(ix,iy,2);
            Rx(end+1) = x_c(ix);
            Ry(end+1) = y_c(iy);
        end
    end
end
B = [Bx' By'];
R = [Rx' Ry'];
I = B(:,1).^2+B(:,2).^2>1e-4;
B = B(I,:);
R = R(I,:);
if nargin>2 && is_plot
    hold all;
    quiver(R(:,1),R(:,2),B(:,1),B(:,2),0,'k','LineWidth',2);
    if nargin>3 && plot_grid
        for x=x_c+a/2
            plot([x x],[0 Ly],'k');
        end
        for y=y_c+a/2
            plot([0 Lx],[y y],'k');
        end
    end
end
end