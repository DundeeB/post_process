function winding = hist_winding(lib, num, psi, E)
load([lib '\state ' num2str(num) '.mat']);
% load('from_ATLAS\N=3600_h=1.0_rhoH=0.85_AF_triangle_ECMC\state 17992800.mat');
% load('from_ATLAS\N=3600_h=1.0_rhoH=0.88_AF_square_ECMC\state 12383280.mat');
% load('from_ATLAS\N=3600_h=1.0_rhoH=0.93_AF_triangle_ECMC\state 17992800.mat');
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
winding = zeros(N_real,1);
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
    winding(i) = winding_number(I,psi,state.spheres);
%     if winding(i) == 1
%         break
%     end
end
%%
hold on;
plot(r(I0,1), r(I0,2), '.', 'MarkerSize',30);
plot(r(I,1),r(I,2),'r','LineWidth',2); 
%%
[counts,centers]=hist(winding,-10:10);  % (abs(n)>0.1)
counts = counts/trapz(centers,counts);
figure(2);
plot(centers, counts,'.--','MarkerSize',20,'LineWidth',2);
legend('pdf of winding number N=3600 h=1 \rho_H=0.93');
set(gca,'FontSize',20);grid on;
xlabel('winding number');
ylabel('pdf');
%%
figure(1);
hold on;
plot(r(I0,1), r(I0,2), '.', 'MarkerSize',30);
rcm = mean(r(I));
dr = r(I)-rcm;
phi = mod(atan2(dr(:,2),dr(:,1)),2*pi);
[~,I_] = sort(phi);
I = I(I_);
plot([r(I,1) ;r(I(1),1)],[r(I,2); r(I(1),2)],'r','LineWidth',2); 
end