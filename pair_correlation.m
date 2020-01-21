function [xij, yij,rs,t] = pair_correlation(state,m,n)
spheres = state.spheres/state.rad;
x_rotated = spheres(:,1); y_rotated = spheres(:,2);
t = -angle(psi_order_parameter(m,n,spheres,1.2*2*state.rad,state.H,false))/(m*n);
x = x_rotated*cos(t)-y_rotated*sin(t);
y = x_rotated*sin(t)+y_rotated*cos(t);
xij = x-x';
yij = y-y';
rs = sqrt(xij(:).^2+yij(:).^2);
% for i = 1:length(xij)
%     xij(i,i) = inf;
%     yij(i,i) = inf;
% end
% [I,J] = size(xij);
% figure; hold on;
% for i=1:I
%     for j=1:J
%         plot(xij(i,j),yij(i,j),'.');    
%     end
% end
end