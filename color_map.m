function [] = color_map(state, psi)

sp = state.spheres/(2*state.rad);
state.cyclic_boundary = state.cyclic_boundary/(2*state.rad);
Heaveside = @(x) x.*(x>0);
rad_avg = 3;

figure; 

subplot(2,1,1); 
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
colorbar('Ticks',[0,0.5,1],...
         'TickLabels',{'<real(\psi)>=-1','|<\psi>|=0','<real(\psi)>=1'})
colormap('jet');
xlabel('x/\sigma');ylabel('y/\sigma');

subplot(2,1,2);
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
rho_red = min(rho); rho_blue = max(rho);
for i=1:length(sp)
    RGB = Heaveside([1-(rho(i)-rho_red)/(rho_blue-rho_red) 0 1-(rho(i)-rho_blue)/(rho_red-rho_blue)]);
    plot(sp(i,1),sp(i,2),'.','Color',RGB,'MarkerSize',7);
end
axis equal;
L = max(state.cyclic_boundary);
xlim([0 L]); ylim([0 L]);
colorbar('Ticks',[0,1],...
         'TickLabels',{['\rho_H=' num2str(rho_blue)],['\rho_H=' num2str(rho_red)]})
colormap('jet');
xlabel('x/\sigma');ylabel('y/\sigma');
end