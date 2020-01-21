function [] = plt_2D_bins(N,C)
wx=C{1}(:);
wy=C{2}(:);
% display
N(abs(wx)<2,abs(wy)<2) = 0;
figure
H = pcolor(wx, wy, N');
box on
shading interp
set(H,'edgecolor','none');
colorbar
colormap jet
set(gca,'FontSize',20);
xlabel('x');ylabel('y');
end