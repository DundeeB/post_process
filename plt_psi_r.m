function [psipsi_sum,counts] = plt_psi_r(counts2D, psipsi_sum2D, ctrs2D, angle, ctrs)
v_hat = [cos(angle) sin(angle)]';
counts = ctrs*0;
psipsi_sum = counts*0;
for i=1:length(ctrs2D{1})
    for j=1:length(ctrs2D{2})
        X = [ctrs2D{1}(i) ctrs2D{2}(j)];
        dist_vec = (v_hat*(X*v_hat)'-X')';
        dist_to_line = sqrt(dist_vec(1).^2+dist_vec(2).^2);
        dx = mean(diff(ctrs));
        Ix = dist_to_line<dx & X*v_hat>0;
        if ~Ix
            continue;
        end
        dist_on_line = X*v_hat;
        for k=2:length(ctrs)
            if dist_on_line>=ctrs(k-1) && dist_on_line<ctrs(k)
                counts(k) = counts(k) + counts2D(i,j);
                psipsi_sum(k) = psipsi_sum(k) + psipsi_sum2D(i,j);
            end
        end
    end
end
end