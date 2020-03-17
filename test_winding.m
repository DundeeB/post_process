% lib='C:\Users\Daniel Abutbul\OneDrive - Technion\simulation-results\N=3600_h=1_rhoH=0.9566559692967636_AF_triangle_ECMC\';
lib = 'C:\Users\Daniel Abutbul\OneDrive - Technion\simulation-results\N=900_h=1_rhoH=0.787295821622217_AF_triangle_ECMC\';
load([lib '/Input_parameters.mat']);
state.spheres = dlmread([lib '\1800000']);  % Initial Conditions
x = state.spheres(:,1); 
y = state.spheres(:,2); 

% xs = [22.3 22.40 20.55];
% ys = [29.85 28.52 28.83];
% I = randi(length(x),3,1);
[psi,E] = psi_mn(2,3,state,true);
figure(1);
%%
N_real = 10000;
n = zeros(N_real,1);
i=0; cutoff = 6;
r = state.spheres;
for i=1:N_real
    i1 = randi(length(x),1);
    drsq = (r(:,1)-r(i1,1)).^2+(r(:,2)-r(i1,2)).^2;
    I2 = find(drsq<cutoff^2);
    i2 = I2(randi(length(I2),1));
    drsq = (r(:,1)-r(i2,1)).^2+(r(:,2)-r(i2,2)).^2;
    I3 = find(drsq<cutoff^2);
    i3 = I3(randi(length(I3),1));
    I0 = [i1 i2 i3];
    I = loop(state, I0, E);
    n(i) = winding_number(I,psi,state.spheres);
end
%%
[counts,centers]=hist(n,-10:10);  % (abs(n)>0.1)
counts = counts/trapz(centers,counts);
figure(2);
plot(centers, counts,'.--','MarkerSize',20,'LineWidth',2);
legend('pdf of winding number');
set(gca,'FontSize',20);grid on;
xlabel('winding number');
ylabel('pdf');
%%
figure(1);
hold on;
plot(x(I0), y(I0), '.', 'MarkerSize',30);
r = [x(I) y(I)]; 
rcm = mean(r);
dr = r-rcm;
phi = mod(atan2(dr(:,2),dr(:,1)),2*pi);
[~,I_] = sort(phi);
r = r(I_,:);
plot([r(:,1) ;r(1,1)],[r(:,2); r(1,2)],'r','LineWidth',2); 