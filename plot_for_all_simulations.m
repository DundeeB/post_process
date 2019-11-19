father_dir = 'simulation-results\';
folds_obj = dir(father_dir);
sim_dirs = {};
for i=1:length(folds_obj)
    f = folds_obj(i).name;
    if sum(strcmp(f,{'.','..','Small or 2D simulations'}))||...
            ~isdir([father_dir f])  
        continue
    end
    sim_dirs{end+1} = ['simulation-results\' f];
end
n = length(sim_dirs);
rho_H_vec = zeros(n,1)*nan;
h_vec = rho_H_vec;
N_vec = rho_H_vec;
psi14_vec = rho_H_vec;
psi23_vec = rho_H_vec;
Sm_pi_pi = rho_H_vec;
b1_vec = rho_H_vec;
for i=1:n
    rho_H_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*rhoH=',''),'_.*',''));
    N_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'_h=.*',''),'.*N=',''));
    h_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*h=',''),'_rhoH.*',''));
    
    cd(sim_dirs{i});
    try
%         load('output.mat');
%         I1 = find(theta*180/pi==45,1,'first');
%         Sm_pi_pi(i) = Sm_theta(end-50,I1);%N_vec(i);
        try
%             load('correct_psi_100_real');
%             psi_vec(i) = psi14(end*2/3);
        end
        try
%             load('output.mat');
            load('output_psi1423_b1_20.mat');
%             load('output_psi14_b1.mat');
%             b1_vec(i) = b(round(end*2/3));
            b1_vec(i) = b(end);
%             psi_vec(i) = psi14(round(end*2/3));
            psi14_vec(i) = psi14(end);
            psi23_vec(i) = psi23(end);
        end
    catch err
        disp(err.message)
    end
    cd('../../');
end
%%
I1N = N_vec == 100;
I2N = N_vec == 400;
I3N = N_vec == 900;
I4N = N_vec == 3600;
figure; hold all;
plt = @(I)plot(rho_H_vec(I), h_vec(I),'.','MarkerSize',15); 
plt(I1N);plt(I2N);plt(I3N);plt(I4N);
legend('100','400','900','3600','location','east');
xlim([0 max(rho_H_vec)]);
ylim([0 1.1]); grid on;
xlabel('\rho_H');ylabel('h');
set(gca,'FontSize',20);
%%
% h = 1;
% I1h = h_vec==h & I1N;
% I2h = h_vec==h & I2N;
% I3h = h_vec==h & I3N;
% I4h = h_vec==h & I4N;
% plt_psi = @(I)plot(rho_H_vec(I),psi_vec(I),'.-','MarkerSize',20);
%%
% h=figure; 
% 
% subplot(2,1,1); hold all;
% plt_psi(I1);plt_psi(I2);plt_psi(I3);plt_psi(I4);
% % xlabel('\rho_H'); 
% legend('h=1, N=100','h=1, N=400','h=1, N=900','h=1, N=3600',...
%     'Location','NorthWest');
% ylabel('|\psi_{14}|');
% set(gca,'FontSize',20); grid on;
% xlim([0 max(rho_H_vec)]);
% 
% subplot(2,1,2); hold all;
% plt_z = @(I)plot(rho_H_vec(I),Sm_pi_pi(I),'.-','MarkerSize',20);
% plt_z(I1);plt_z(I2);plt_z(I3);plt_z(I4);
% xlabel('\rho_H');
% grid on;
% % legend('h=0.7, N=100','h=0.7, N=400','h=0.7, N=900','h=0.7, N=3600',...
% %     'Location','NorthWest');
% ylabel('<|z(k=(\pi,\pi))/(h\sigma)|^2>');
% set(gca,'FontSize',20);
% xlim([0 max(rho_H_vec)]);
% savefig(h,'graphs\magnetic_Bragg_vs_h');
%%
j=figure; 

h = 1;
I1h = h_vec==h & I1N;
I2h = h_vec==h & I2N;
I3h = h_vec==h & I3N;
I4h = h_vec==h & I4N;
plt_psi23 = @(I)plot(rho_H_vec(I),abs(psi23_vec(I)),'.','MarkerSize',20);
subplot(2,1,1); 
hold all;
% plt_psi(I1h);plt_psi(I2h);plt_psi(I3h);plt_psi(I4h);
plt_psi23(I3h)
% xlabel('\rho_H'); 
% legend('h=1, N=100','h=1, N=400','h=1, N=900','h=1, N=3600',...
%     'Location','NorthWest');
% ylabel('|\psi_{14}|');
ylabel('Order parameter');
set(gca,'FontSize',20); grid on;
xlim([0 max(rho_H_vec)]);

% subplot(2,1,2);
hold all;
plt_b1 = @(I)plot(rho_H_vec(I),2*(b1_vec(I)-0.5),'.','MarkerSize',20);
% plt_b1(I1h);plt_b1(I2h);plt_b1(I3h);plt_b1(I4h);
plt_b1(I3h);
xlabel('\rho_H');
grid on;
% ylabel('2(b_1-1/2)');
set(gca,'FontSize',20);
% xlim([0 max(rho_H_vec)]);
% ylim([0.5 1]);
h_str = ['h=' num2str(h) ', '];
legend([h_str 'N=900, |\psi_{23}|'],[h_str 'N=900, 2*(b_1-1/2)'],...
    'Location','NorthWest');

h = 0.8;
I1h = h_vec==h & I1N;
I2h = h_vec==h & I2N;
I3h = h_vec==h & I3N;
I4h = h_vec==h & I4N;
plt_psi14 = @(I)plot(rho_H_vec(I),abs(psi14_vec(I)),'.','MarkerSize',20);
subplot(2,1,2); 
hold all;
% plt_psi(I1h);plt_psi(I2h);plt_psi(I3h);plt_psi(I4h);
plt_psi14(I3h)
% xlabel('\rho_H'); 
% legend('h=1, N=100','h=1, N=400','h=1, N=900','h=1, N=3600',...
%     'Location','NorthWest');
% ylabel('|\psi_{14}|');
ylabel('Order parameter');
set(gca,'FontSize',20); grid on;
xlim([0 max(rho_H_vec)]);

% subplot(2,1,2);
hold all;
plt_b1 = @(I)plot(rho_H_vec(I),2*(b1_vec(I)-0.5),'.','MarkerSize',20);
% plt_b1(I1h);plt_b1(I2h);plt_b1(I3h);plt_b1(I4h);
plt_b1(I3h);
xlabel('\rho_H');
grid on;
% ylabel('2(b_1-1/2)');
set(gca,'FontSize',20);
% xlim([0 max(rho_H_vec)]);
% ylim([0.5 1]);
h_str = ['h=' num2str(h) ', '];
legend([h_str 'N=900, |\psi_{14}|'],[h_str 'N=900, 2*(b_1-1/2)'],...
    'Location','NorthWest');
savefig(j,'graphs\magnetic_Bragg_vs_h');