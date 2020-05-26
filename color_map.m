function [psi_avg, rho, Lx_c, Ly_c] = color_map(state, psi)

sp = state.spheres/(2*state.rad);
state.cyclic_boundary = state.cyclic_boundary/(2*state.rad);
L = max(state.cyclic_boundary);
Heaveside = @(x) x.*(x>0);
rad_avg = 2;

figure; 

subplot(2,2,1); 
hold on;
psi_avg = zeros(size(psi));
for i=1:length(sp)
    dr = zeros(size(psi));
    for j=1:length(dr)
        dr(j) = cyclic_dist(sp(i,:),sp(j,:),state.cyclic_boundary);
    end
    I = dr<rad_avg;
    psi_ = mean(psi(I));
    psi_avg(i) = psi_;
%     g = 1-abs(psi_);
%     RGB = Heaveside([real(psi_) g -real(psi_)]);
    r = abs(psi_);
    RGB = Heaveside([r 1-2*abs(r-1/2) 1-r]);
    plot(sp(i,1),sp(i,2),'.','Color',RGB,'MarkerSize',7);
end
axis equal;
xlim([0 L]); ylim([0 L]);
% colorbar('northoutside','Ticks',[0,0.5,1],...
%          'TickLabels',{'<real(\psi)>=-1','|<\psi>|=0','<real(\psi)>=1'})
colorbar('northoutside','Ticks',[0,1],...
         'TickLabels',{'|<\psi>|=0','|<\psi>|=1'})
colormap('jet');
xlabel('x/\sigma');ylabel('y/\sigma');
set(gca,'fontsize',15);

subplot(2,2,3); hold on; 
[counts,centers] = hist(abs(psi_avg),20);
plot(centers,counts/trapz(centers,counts),'o-','LineWidth',3);
xlabel('|\psi|'); ylabel('pdf');
set(gca,'FontSize',15); 
grid on;

N_res = sqrt(length(sp));
dL = L/N_res;
Lx_walls = 0:dL:state.cyclic_boundary(1);
Ly_walls = 0:dL:state.cyclic_boundary(2);
Lx_c = Lx_walls(1:end-1)+diff(Lx_walls)/2;
Ly_c = Ly_walls(1:end-1)+diff(Ly_walls)/2;
rho = zeros(length(Lx_c),length(Ly_c));
rad = rad_avg;
A = pi*rad^2;
V = A*state.H/(2*state.rad);
for i=1:length(Lx_c)
    for j=1:length(Ly_c)
%         I = sp(:,1)>Lx_walls(i) & sp(:,1)<Lx_walls(i+1) & ...
%             sp(:,2)>Ly_walls(j) & sp(:,2)<Ly_walls(j+1);
%         A = (Lx_walls(i+1)-Lx_walls(i))*(Ly_walls(j+1)-Ly_walls(j));
        dr = zeros(size(psi));
        for k=1:length(dr)
            dr(k) = cyclic_dist([Lx_c(i) Ly_c(j)],sp(k,:),state.cyclic_boundary);
        end
        I = dr<rad;
        rho(i,j) = sum(I)/V;
    end
end

subplot(2,2,2);
hold on;
h = pcolor(Lx_c,Ly_c,rho');
h.EdgeColor = 'none';
axis equal;
xlim([0 L]); ylim([0 L]);
c=colorbar('northoutside');
c.Label.String = '\rho_H';
colormap('jet');
xlabel('x/\sigma');ylabel('y/\sigma');
set(gca,'fontsize',15);

subplot(2,2,4); hold on; 
rho_options = (0:round(V*1.2))/V;
[counts,centers] = hist(rho(:),rho_options);
plot(centers,counts/trapz(centers,counts),'o-','LineWidth',3);
xlabel('\rho_H'); ylabel('pdf');
set(gca,'FontSize',15); 
grid on;
end