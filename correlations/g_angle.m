function [g, rc, counts] = g_angle(state, angle, isplot)
% dtheta = 0.1;
width = 1;
dr = 0.1;

sp = state.spheres/(2*state.rad);
cb = state.cyclic_boundary/(2*state.rad);
A = cb(1)*cb(2);
eta = length(sp)/A;
rmax = min(cb)/2;

xij = sp(:,1)-sp(:,1)'; 
yij = sp(:,2)-sp(:,2)'; 
rij_vec = cyclic_vec([xij(:) yij(:)], cb);
xij = rij_vec(:,1);
yij = rij_vec(:,2);
v_hat = [cos(angle) sin(angle)]';

if nargin>2 && isplot
%     figure; 
    subplot(1,2,1);
    
    xlabel('x/\sigma');ylabel('y/\sigma');
    hold on;
    I_ = abs(xij)<10 & abs(yij)<10 & sqrt(xij.^2+yij.^2)>0.1;
    x = xij(I_);
    y = yij(I_);
    [N,c]=hist3([x y],'Nbins',[200 200]);
    p=pcolor(c{1},c{2},N./mean(N(:)));
    p.EdgeColor = 'none';
    colorbar('northoutside');
    plot([0;10]*cos(angle),[0;10]*sin(angle),'k','LineWidth',1);
    axis equal;
    xlim([-10 10]);
    ylim([-10 10]);
end

t = [xij yij]*v_hat;
vec_to_line = [xij yij]-t*v_hat';
dist_to_line = sqrt(vec_to_line(:,1).^2+vec_to_line(:,2).^2);
I = dist_to_line<width/2 & t>0.1 & t<rmax;
% theta = atan2(yij,xij);
% I = theta>angle-dtheta/2 & theta<angle+dtheta/2;
rs = sqrt(xij(I).^2+yij(I).^2);

r = ([0:dr:rmax])';
rc = r(1:end-1)+diff(r)/2;
g = zeros(size(rc));
counts = zeros(size(rc));
for i=1:length(rc)
    I = rs>r(i) & rs<r(i+1);
    counts(i) = sum(I);
end
% g = counts./(rc*dtheta*dr*eta)/length(sp);
g = counts./(width*dr*eta)/length(sp);
if nargin>2 && isplot
    subplot(1,2,2);
    loglog(rc,g-1);
    set(gca,'FontSize',20);
    xlabel('\Deltar/\sigma');
    ylabel('g(r)-1');
end