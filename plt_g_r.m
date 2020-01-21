function [Nbins,Centers] = plt_g_r(xij,yij,L, t,isplot)
N = length(xij);
rs = sqrt(xij(:).^2+yij(:).^2);
I_no0 = rs>0;
v_hat = [cos(t) sin(t)]';
X = [xij(:) yij(:)];
dist_vec = (v_hat*(X*v_hat)'-X')';
dist_to_line = sqrt(dist_vec(:,1).^2+dist_vec(:,2).^2);
Ix = dist_to_line<0.5 & dist_to_line>0 & X*v_hat>0;
if nargin<5 || isplot
    densityplot(xij(I_no0), yij(I_no0),[N/4 N/4]);
    xlim([-L L]); ylim([-L L]);
    hold on;
    plot(xij(Ix),yij(Ix),'r','LineWidth',2);
    figure;
    hist(rs(Ix),N);
    xlim([0 L]);
end
[Nbins,Centers] = hist(rs(Ix),N);
end