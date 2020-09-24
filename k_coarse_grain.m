function [B, R] = k_coarse_grain(sim_path, k, is_plot, plot_colors)
if nargin<3
    is_plot = false;
    plot_colors=false;
else
    if nargin<4
        plot_colors = false;
    end
end
[burg, sp, boundaries] = visualize_burger(sim_path, is_plot && (~plot_colors));
r = burg(:,1:2);
b = burg(:,3:4);
Lx = boundaries(1);
Ly = boundaries(2);

idx = kmeans(r,k);
R = zeros(k,2);
B = zeros(k,2);
for l=1:k
    I = idx==l;
    R(l,:) = mean(r(I,:),1);
    B(l,:) = sum(b(I,:),1);
end
if is_plot
    if plot_colors
        plt = @(l) quiver(r(idx==l,1),r(idx==l,2), b(idx==l,1),b(idx==l,2),0,'linewidth',1);
        hold all;
        for l=1:k
            plt(l);
        end
    end
    quiver(R(:,1),R(:,2),B(:,1),B(:,2),0,'k','LineWidth',2);
%     plot(R(:,1),R(:,2),'+r','LineWidth',4);
    axis equal;
    xlim([0 boundaries(1)]);
    ylim([0 boundaries(2)]);
end
end