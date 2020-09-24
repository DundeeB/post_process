sim_path = 'from_ATLAS2.0\N=8100_h=0.8_rhoH=0.81_AF_triangle_ECMC\';
[burg, sp, boundaries] = visualize_burger(sim_path, true);
% [B, R] = collapse_burger(sim_path, 0.1, true);
B = burg(:,3:4);
R = burg(:,1:2);
k=10;
idx = kmeans(R,k);
plt = @(l) quiver(R(idx==l,1),R(idx==l,2), B(idx==l,1),B(idx==l,2),0,'linewidth',2);
hold all;
for l=1:k
    plt(l);
end
axis equal;
title(['k-means with k=' num2str(k)]);
set(gca,'fontsize',20);
xlim([0 boundaries(1)]);
ylim([0 boundaries(2)]);