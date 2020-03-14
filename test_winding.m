lib='C:\Users\Daniel Abutbul\OneDrive - Technion\simulation-results\N=900_h=1_rhoH=0.8365018104736054_AF_triangle_ECMC\';
load([lib '/Input_parameters.mat']);
state.spheres = dlmread([lib '\100800']);
x = state.spheres(:,1); 
y = state.spheres(:,2); 

% xs = [22.3 22.40 20.55];
% ys = [29.85 28.52 28.83];
% I = randi(length(x),3,1);
I = find(x<19 & x>17 & y<14 & y>11);
xs = x(I);
ys = y(I);
I=[];
for j=1:length(xs)
x_=xs(j);
y_ = ys(j);
[~,i] = min((x-x_).^2+(y-y_).^2);
I=[I i];
end
psi23 = psi_mn(2,3,state);
n = winding_number(I,psi23,state.spheres)

knn_based_bonds(state, 3,true);hold on;

r = [x(I) y(I)]; 
rcm = mean(r);
dr = r-rcm;
phi = mod(atan2(dr(:,2),dr(:,1)),2*pi);
[~,I_] = sort(phi);
r = r(I_,:);
plot([r(:,1) ;r(1,1)],[r(:,2); r(1,2)],'r','LineWidth',2); 

quiver(x,y,real(psi23),imag(psi23));