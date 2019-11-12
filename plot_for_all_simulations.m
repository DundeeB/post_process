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
psi_vec = rho_H_vec;
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
        load('output.mat');
        I1 = find(theta*180/pi==45,1,'first');
        Sm_pi_pi(i) = Sm_theta(end-50,I1);%N_vec(i);
        try
            load('correct_psi_100_real');
            psi_vec(i) = psi14(end);
        end
        try
            load('M_fr_100_real');
            b1_vec(i) = b(end);
        end
    catch err
        disp(err.message)
    end
    cd('../../');
end
%%
I1 = N_vec == 100;
I2 = N_vec == 400;
I3 = N_vec == 900;
I4 = N_vec == 3600;
figure; hold all;
plt = @(I)plot(rho_H_vec(I), h_vec(I),'.','MarkerSize',15); 
plt(I1);plt(I2);plt(I3);plt(I4);
legend('100','400','900','3600');
xlim([0 1.15]); ylim([0 1]);
xlabel('\rho_H');ylabel('h');
set(gca,'FontSize',20);
%%
h=figure; 

subplot(2,1,1); hold all;
I1 = h_vec==0.7 & N_vec==100;
I2 = h_vec==0.7 & N_vec==400;
I3 = h_vec==0.7 & N_vec==900;
I4 = h_vec==0.7 & N_vec==3600;
plt_psi = @(I)plot(rho_H_vec(I),psi_vec(I),'.-','MarkerSize',20);
plt_psi(I1);plt_psi(I2);plt_psi(I3);plt_psi(I4);
% xlabel('\rho_H'); 
legend('h=0.7, N=100','h=0.7, N=400','h=0.7, N=900','h=0.7, N=3600',...
    'Location','NorthWest');
ylabel('|\psi_{14}|');
set(gca,'FontSize',20); grid on;

subplot(2,1,2); hold all;
plt_z = @(I)plot(rho_H_vec(I),Sm_pi_pi(I),'.-','MarkerSize',20);
plt_z(I1);plt_z(I2);plt_z(I3);plt_z(I4);
xlabel('\rho_H');
grid on;
% legend('h=0.7, N=100','h=0.7, N=400','h=0.7, N=900','h=0.7, N=3600',...
%     'Location','NorthWest');
ylabel('<|z(k=(\pi,\pi))/(h\sigma)|^2>');
set(gca,'FontSize',20);

savefig(h,'graphs\magnetic_Bragg_vs_h');
%%
j=figure; 

subplot(2,1,1); hold all;
plt_psi(I1);plt_psi(I2);plt_psi(I3);plt_psi(I4);
% xlabel('\rho_H'); 
legend('h=0.7, N=100','h=0.7, N=400','h=0.7, N=900','h=0.7, N=3600',...
    'Location','NorthWest');
ylabel('|\psi_{14}|');
set(gca,'FontSize',20); grid on;


subplot(2,1,2); hold all;
plt_b1 = @(I)plot(rho_H_vec(I),b1_vec(I),'.-','MarkerSize',20);
plt_b1(I1);plt_b1(I2);plt_b1(I3);plt_b1(I4);
xlabel('\rho_H');
grid on;
ylabel('b_1');
set(gca,'FontSize',20);

savefig(j,'graphs\magnetic_Bragg_vs_h');