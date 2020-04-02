function [] = color_map(state, psi)

sp = state.spheres/(2*state.rad);
state.cyclic_boundary = state.cyclic_boundary/(2*state.rad);
Heaveside = @(x) x.*(x>0);
rad_avg = 5;

figure; 

subplot(2,2,1); 
hold on;
for i=1:length(sp)
    dr = zeros(size(psi));
    for j=1:length(dr)
        dr(j) = cyclic_dist(sp(i,:),sp(j,:),state.cyclic_boundary);
    end
    I = dr<rad_avg;
    psi_ = mean(psi(I));
    b = 1-abs(mean(psi(I)));
    RGB = Heaveside([real(psi_) b -real(psi_)]);
    plot(sp(i,1),sp(i,2),'.','Color',RGB,'MarkerSize',7);
end
axis equal;
L = max(state.cyclic_boundary);
xlim([0 L]); ylim([0 L]);
colorbar('northoutside','Ticks',[0,0.5,1],...
         'TickLabels',{'<real(\psi)>=-1','|<\psi>|=0','<real(\psi)>=1'})
colormap('jet');
xlabel('x/\sigma');ylabel('y/\sigma');

subplot(2,2,3); hold on; 
[counts,centers] = hist(abs(psi));
plot(centers,counts/trapz(centers,counts),'o-','LineWidth',3);
xlabel('|\psi|'); ylabel('pdf');
% set(gca,'FontSize',20); 
grid on;

subplot(2,2,2);
hold on;
rho = zeros(size(psi));
for i=1:length(sp)
    dr = zeros(size(psi));
    for j=1:length(dr)
        dr(j) = cyclic_dist(sp(i,:),sp(j,:),state.cyclic_boundary);
    end
    I = dr<rad_avg;
    rho(i) = sum(I)/(pi*rad_avg^2*state.H/(2*state.rad));
end
rho_green = min(rho); rho_blue = max(rho);
for i=1:length(sp)
    RGB = Heaveside([0 1-(rho(i)-rho_green)/(rho_blue-rho_green) 1-(rho(i)-rho_blue)/(rho_green-rho_blue)]);
    plot(sp(i,1),sp(i,2),'.','Color',RGB,'MarkerSize',7);
end
axis equal;
L = max(state.cyclic_boundary);
xlim([0 L]); ylim([0 L]);
c=colorbar('northoutside','Ticks',[0,0.5],...
         'TickLabels',{['\rho_H=' num2str(rho_blue)],['\rho_H=' num2str(rho_green)]});
colormap('jet');
c.Limits = [ 0 0.5];
xlabel('x/\sigma');ylabel('y/\sigma');
end