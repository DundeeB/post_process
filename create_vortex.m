vortex_charge=2;
n = 3;
m = 2;

lib = 'C:\Users\Daniel Abutbul\OneDrive - Technion\simulation-results\N=900_h=1_rhoH=0.787295821622217_AF_triangle_ECMC\';
load([lib '/Input_parameters.mat']);
rcm = mean([28.45 16.88;29.77 16.83; 30.47 15.71;29.77 14.49; 
    28.44 14.53; 27.74 15.66]);%mean(state.spheres);
sp = state.spheres(:,1:2) - rcm;
t = mod(atan2(sp(:,2),sp(:,1))-pi/6,2*pi);
r = sqrt(sp(:,2).^2+sp(:,1).^2);
I = t>2*pi/(m*n)*vortex_charge;
t_ = m*n/(m*n-vortex_charge)*t(I)-2*pi/(m*n-vortex_charge); 
r_ = r(I);
x = r_.*cos(t_)+rcm(1);
y = r_.*sin(t_)+rcm(2);
%%
figure;
plot(r.*cos(t),r.*sin(t),'o');axis equal;
hold all; 
plot([0;r],[0;r]*0);
phi = 2*pi/(m*n)*vortex_charge;
plot([0;r]*cos(phi),[0;r]*sin(phi));
% subplot(2,1,2);
figure;
plot(x,y,'o');
hold all;
plot([0;r],[0;r]*0);
axis equal;
%%
state.cyclic_boundary = state.cyclic_boundary*2;
state.spheres = [x y state.spheres(I,3)];
[psi,E] = psi_mn(m,n,state,true);
%%
N_real = 10000;
n = zeros(N_real,1);
i=0; cutoff = inf;
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
    if n(i) == 1
        break
    end
end
%%
[counts,centers]=hist(n,-10:10);  % (abs(n)>0.1)
counts = counts/trapz(centers,counts);
figure(4);
plot(centers, counts,'.--','MarkerSize',20,'LineWidth',2);
legend('pdf of winding number');
set(gca,'FontSize',20);grid on;
xlabel('winding number');
ylabel('pdf');
%%
figure(3);
hold on;
plot(x(I0), y(I0), '.', 'MarkerSize',30);
plot(r(I,1),r(I,2),'r','LineWidth',2); 