function [xij, yij] = pair_correlation(state)
spheres = state.spheres;
x_rotated = spheres(:,1); y_rotated = spheres(:,2);
t = -angle(psi_order_parameter(1,4,spheres,1.2*2*state.rad,state.H,false))/4;
x = x_rotated*cos(t)-y_rotated*sin(t);
y = x_rotated*sin(t)+y_rotated*cos(t);
xij = x-x';
yij = y-y';
% [I,J] = size(xij);
% figure; hold on;
% for i=1:I
%     for j=1:J
%         plot(xij(i,j),yij(i,j),'.');    
%     end
% end
end