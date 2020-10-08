function [B, R, b, r] = nearest_neighbor_coarse_graining(sim_path, is_plot, plot_colors)
[burg, sp, boundaries] = visualize_burger(sim_path, is_plot,~plot_colors);
r = burg(:,1:2);
b = burg(:,3:4);
Lx = boundaries(1);
Ly = boundaries(2);
state.spheres = r;
state.cyclic_boundary = boundaries(1:2);
E_d = knn_based_bonds(state, 1, false);
E = bonds_from_directed_graph(E_d, state, 1, false);
B = []; 
R = [];
all_spheres = r(:,1)>-inf;
for i=1:length(E)
    all_spheres(E(i,1)) = false;
    all_spheres(E(i,2)) = false;
    if norm(b(E(i,1),:)+b(E(i,2),:))<1e-3
        continue
    end
    B = [B ; b(E(i,1),:); b(E(i,2),:)];
    R = [R; r(E(i,1),:); r(E(i,2),:)];
end
B = [B ; b(all_spheres,:)];
R = [R ; r(all_spheres,:)];
if is_plot
    quiver(R(:,1),R(:,2),B(:,1),B(:,2),0,'k','LineWidth',3);
    if plot_colors
        hold all;
        for l=1:length(E)
            idx = E(l,:);
            quiver(r(idx,1),r(idx,2), b(idx,1),b(idx,2),0);
%             plot(r(idx,1),r(idx,2));
        end
        quiver(r(all_spheres,1),r(all_spheres,2), b(all_spheres,1),b(all_spheres,2),0,'r','linewidth',1);
    end
    axis equal;
    xlim([0 boundaries(1)]);
    ylim([0 boundaries(2)]);
end
end

function r_cm = cyclic_mean(r1,r2,cyclic_boundary)
dr = cyclic_vec(r2-r1,cyclic_boundary);
r_cm = mod((r1+(r1+dr))/2, cyclic_boundary);
end