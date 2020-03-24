function p = p_q_analysis(lib, num, psi, E)
load([lib '\state ' num2str(num) '.mat']);
if nargin == 2
    [psi,E] = psi_mn(2,3,state,false);
    E = bonds_from_directed_graph(E, state, 3, true);
    hold on; quiver(state.spheres(:,1), state.spheres(:,2), real(psi), ...
        imag(psi));
    L = max(state.cyclic_boundary(1:2));
    axis equal;
    xlim([0 L]);
    ylim([0 L]);
end
%%
N_real = 10000;
rho = zeros(N_real,1);
cutoff = 30;
r = state.spheres;
rcm = mean(r);
for i=1:N_real
    I0 = [];
    for j=1:4
        while true
            i_ = randi(length(r),1);
            if abs(r(i_,1)-rcm(1))<cutoff && abs(r(i_,2)-rcm(2))<cutoff && ...
                    abs(r(i_,1)-rcm(1))>3 && abs(r(i_,2)-rcm(2))>3
                I0 = [I0 i_];
                break
            end
        end
    end
    I = loop(state, I0, E);
    in = inpolygon(r(:,1),r(:,2),r(I,1),r(I,2));
    rho(i) = winding_number(I,psi,state.spheres)/sum(in);
%     if winding(i) == 1
%         break
%     end
end
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
p = fmincon(eq_zero,(0.1:0.1:0.4)',[],[],[],[],[0;0;0;0],[inf;inf;inf;inf]);
%%
figure;
p_ = [p(1:2);0;p(3:4)];
q_ = [q(1:2);0;q(3:4)];
plot(q_,p_,'*--');
xlabel('q');ylabel('p_q');
set(gca,'FontSize',20);
grid on;
%%
figure;
hist(rho,30);
grid on;
set(gca,'FontSize',20);
xlabel('\rho=Q/n with Q=\intd(arg(\psi_{23}))');
ylabel('Counts');
end