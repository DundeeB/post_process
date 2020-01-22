function [Nbins,Centers] = plt_g_r(xij, yij, Length, angle, ctrs, isplot)
N = length(xij);
rs = sqrt(xij(:).^2+yij(:).^2);
I_no0 = rs>0;
v_hat = [cos(angle) sin(angle)]';
X = [xij(:) yij(:)];
dist_vec = (v_hat*(X*v_hat)'-X')';
dist_to_line = sqrt(dist_vec(:,1).^2+dist_vec(:,2).^2);
dx = mean(diff(ctrs));
Ix = dist_to_line<dx & X*v_hat>0;
if nargin==5 || isplot
    densityplot(xij(I_no0), yij(I_no0),[N/2 N/2]);
    xlim([-Length Length]); ylim([-Length Length]);
    hold on;
    plot(xij(Ix),yij(Ix),'*--Black');
    figure;
    hist(rs(Ix),N);
    xlim([0 Length]);
end
[Nbins,Centers] = hist(rs(Ix),ctrs);
Nbins = Nbins/mean(Nbins);
end