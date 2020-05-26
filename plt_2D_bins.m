function [] = plt_2D_bins(N,C)
wx=C{1}(:);
wy=C{2}(:);
% display
N(abs(wx)<0.5,abs(wy)<0.5) = 0;
figure
H = pcolor(wx, wy, N');
box on
shading interp
set(H,'edgecolor','none');
colorbar
colormap jet
set(gca,'FontSize',20);
xlabel('\Deltax');ylabel('\Deltay');
end