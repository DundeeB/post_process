function [B, R] = annihilate_coarse_grain(sim_path, rad, is_plot, pair_couples)
if is_plot
    figure;
end
[burg, sp, boundaries] = visualize_burger(sim_path, is_plot,false);
r = burg(:,1:2);
b = burg(:,3:4);
if pair_couples
    [B,R] = nearest_neighbor_coarse_graining(sim_path, false, false);
else
    R = burg(:,1:2);
    B = burg(:,3:4);
end
% b = B;
% r = R;
i=1;    
while i<=length(R)
    I_m_i = [1:i-1 i+1:length(R)];
    dr = zeros(size(I_m_i));
    for j=1:length(I_m_i)
        dr(j) = cyclic_dist(R(i,:),R(I_m_i(j),:),boundaries(1:2));
    end
    [m,j_m_i] = min(dr);  % which one is nearest to i
    j = I_m_i(j_m_i);  % j is it's index
    if m<rad
        I_m_ij = [1:min(i,j)-1 min(i,j)+1:max(i,j)-1 max(i,j)+1:length(R)];
        B_ = B(i,:)+B(j,:);
        if norm(B_)>1e-3
            B = [B(I_m_ij,:); B_];
            R = [R(I_m_ij,:); cyclic_mean(R(i,:),R(j,:),boundaries(1:2))];
        else
            B = B(I_m_ij,:);
            R = R(I_m_ij,:);
        end
        i = min(i,j)-1;
    end
    i = i+1;
end
if is_plot
    hold all;
    quiver(R(:,1),R(:,2), B(:,1),B(:,2),0,'k','linewidth',3);
    quiver(r(:,1),r(:,2),b(:,1),b(:,2),0,'r');
    axis equal;
    xlim([0 boundaries(1)]);
    ylim([0 boundaries(2)]);
end
end


function r_cm = cyclic_mean(r1,r2,cyclic_boundary)
dr = cyclic_vec(r2-r1,cyclic_boundary);
r_cm = mod((r1+(r1+dr))/2, cyclic_boundary);
end