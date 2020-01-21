function [] = plt_g_r(xij,yij,L)
N = length(xij);
rs = sqrt(xij(:).^2+yij(:).^2);
I_no0 = rs>0;
densityplot(xij(I_no0), yij(I_no0),[N/4 N/4]);
xlim([-L L]); ylim([-L L]);
hold on;
plot([0 L],[0 0],'r','LineWidth',2);
figure;
Ix = abs(yij(:))<2 & xij(:)>0;
hist(xij(Ix),N);
xlim([0 L]);
end