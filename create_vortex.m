close all; clear all; clc;
vortex_charge=2;
n = 3;
m = 2;
%%
sp = [];
v = @(n) [cos(n*pi/3) sin(n*pi/3)];
a = @(n1,n2) v(n1)-v(n2);
a1 = a(0,4);
a2 = a(2,4);
b = a(5,4);
r0 = v(4);
for n1 = -20:20
    for n2=-20:20
        sA = n1*a1+n2*a2+r0;
        sB = sA + b;
        sp = [sp; [sA 1]; [sB 3]];
    end
end
rcm = -[min(sp(:,1)) min(sp(:,2)) 0];
sp = sp + rcm;
state.spheres = sp;
state.cyclic_boundary = [max(sp(:,1)) max(sp(:,2))];
state.H = 4;
%%
sp = sp - rcm;
t = mod(atan2(sp(:,2),sp(:,1))-0.01,2*pi);
r = sqrt(sp(:,2).^2+sp(:,1).^2);
tcm = mod(atan2(rcm(2),rcm(1))-0.01,2*pi);
rcm_size = sqrt(rcm(2).^2+rcm(1).^2);
I = t>=2*pi/(m*n)*vortex_charge;
sp = sp + rcm;
%%
figure;
plot(sp(:,1),sp(:,2),'.b','MarkerSize',15);axis equal;
hold all;
plot(sp(I,1),sp(I,2),'.r','MarkerSize',15);
phi1 = 0; 
phi2=2*pi/(m*n)*vortex_charge;
plt = @(phi,rcm) plot(rcm(1)+state.cyclic_boundary(1)*[0 cos(phi)],...
    rcm(2)+state.cyclic_boundary(1)*[0 sin(phi)],'LineWidth',2);
plt(phi1,rcm);
plt(phi2,rcm);
%%
sp = sp - rcm;
A = m*n/(m*n-vortex_charge);
t_ = A*t(I)-vortex_charge*2*pi/(m*n-vortex_charge); 

% factor = 500;
% r_ = r(I).^A;

factor = inf;
r_ = r(I);

tcm = m*n/(m*n-vortex_charge)*tcm-vortex_charge*2*pi/(m*n-vortex_charge); 

rcm_ = -[min(r_.*cos(t_)) min(r_.*sin(t_)) 0];
x = r_.*cos(t_)+rcm_(1);
y = r_.*sin(t_)+rcm_(2);
z = state.spheres(I,3);
sp = sp + rcm;
%%
l = 40;
xl = rcm_(1)-l;
yl = rcm_(2)-l;
yu = rcm_(2)+l;
xu = rcm_(1)+l;

figure;
plot(x,y,'.b','MarkerSize',15);
hold all;
plot(x*0+xl,y,'k','LineWidth',2); 
plot(x*0+xu,y,'k','LineWidth',2);
plot(x,y*0+yl,'k','LineWidth',2);
plot(x,y*0+yu,'k','LineWidth',2);
plot(rcm_(1),rcm_(2),'.r','MarkerSize',25);
%%
I2 = x>xl & x<xu & y>yl & y<yu;
x = x(I2)-xl; y = y(I2)-yl;z = z(I2); 
rcm_= rcm_-[xl yl 0];
state.cyclic_boundary=[(xu-xl) (yu-yl)];
%%
figure;
plot(x,y,'.b','MarkerSize',15);
hold all;
plt(phi1,rcm_);
plot(rcm_(1),rcm_(2),'.r','MarkerSize',25);
xlim([0 (xu-xl)]);
ylim([0 (yu-yl)]);
%%
state.spheres = [x y z];
[psi,E] = psi_mn(m,n,state,true);
%%
N_real = 1000;
winding = zeros(N_real,1);
rho = zeros(N_real,1);
cutoff = 4*factor;
for i=1:N_real
    I0 = [];
    for j=1:4
        while true
            i_ = randi(length(x),1);
            if abs(x(i_)-rcm_(1))<cutoff && abs(y(i_)-rcm_(2))<cutoff && ...
                    abs(x(i_)-rcm_(1))>3&& abs(y(i_)-rcm_(2))>3
%                     abs(x(i_)-rcm_(1))>3*factor&& abs(y(i_)-rcm_(2))>3*factor
                I0 = [I0 i_];
                break
            end
        end
    end
    I = loop(state, I0, E);
    winding(i) = winding_number(I,psi,state.spheres);
    in = inpolygon(x,y,x(I),y(I));
    rho(i) = winding_number(I,psi,state.spheres)/sum(in);
%     if winding(i) == -4
%         break
%     end
end
%%
hold on;
plot(x(I0), y(I0), '.', 'MarkerSize',30);
plot(x(I),y(I),'r','LineWidth',2); 
%%
[counts,centers]=hist(winding,-10:10);  % (abs(n)>0.1)
counts = counts/trapz(centers,counts);
figure;
plot(centers, counts,'.--','MarkerSize',20,'LineWidth',2);
legend('pdf of winding number');
set(gca,'FontSize',20);grid on;
xlabel('winding number');
ylabel('pdf');
%%
m1 = mean(rho);
m2 = mean(rho.^2); 
m3 = mean(rho.^3); 
m4 = mean(rho.^4); 
m_ = [m1; m2; m3; m4];

q = [-2 -1 1 2]';
k1 = @(p) sum(q.*p);
k2 = @(p) sum(q.^2.*p.*(1-p));
k3 = @(p) sum(q.^3.*p.*(1-p).*(1-2*p));
k4 = @(p) sum(q.^4.*p.*(1-p).*(1-6*p.*(1-p)));
m1 = @(p) k1(p);
m2 = @(p) k2(p)+k1(p)^2;
m3 = @(p) k3(p)+3*k2(p)*k1(p)+k1(p)^3;
m4 = @(p) k4(p)+4*k3(p)*k1(p)+3*k2(p)^2 + 6*k2(p)*k1(p)^2+k1(p)^4;
m = @(p) [m1(p); m2(p); m3(p); m4(p)];
eq_zero = @(p) sum((m(p)-m_).^2);
% p = fminsearch(eq_zero, (0.1:0.1:0.4)')
p = fmincon(eq_zero,(0.1:0.1:0.4)',[],[],[],[],[0;0;0;0],[inf;inf;inf;inf])
%%
figure;
hist(rho,30);
grid on;
set(gca,'FontSize',20);
xlabel('\rho=Q/n with Q=\intd(arg(\psi_{23}))');
ylabel('Counts');
%%
figure;
p_ = [p(1:2);0;p(3:4)];
q_ = [q(1:2);0;q(3:4)];
plot(q_,p_,'*--');
xlabel('q');ylabel('p_q');
set(gca,'FontSize',20);
grid on;