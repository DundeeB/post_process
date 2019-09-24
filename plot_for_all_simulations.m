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
rho_H_vec = zeros(n,1);
h_vec = rho_H_vec;
N_vec = rho_H_vec;
psi_vec = rho_H_vec;
Sm_pi_pi = rho_H_vec;
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
        I = find(theta*180/pi==45,1,'first');
        Sm_pi_pi(i) = Sm_theta(end-50,I);
        try
            load('correct_psi_100_real');
        end
        psi_vec(i) = psi14(end);
    catch err
        disp(err.message)
    end
    cd('../../');
end
%%
h=figure; 

subplot(2,1,1); hold all;
I = h_vec==0.7 & N_vec==3600;
I2 = h_vec==0.7 & N_vec==900;
plot(rho_H_vec(I),(psi_vec(I)),'.--','MarkerSize',30);
plot(rho_H_vec(I2),(psi_vec(I2)),'.-','MarkerSize',10);
xlabel('\rho_H'); 
legend('h=0.7, N=3600','h=0.7, N=900','Location','NorthWest');
ylabel('|\psi_{14}|');
set(gca,'FontSize',20); grid on;

subplot(2,1,2); hold all;
I = rho_H_vec==0.4 & N_vec==3600;
I2 = rho_H_vec==0.4 & N_vec==900;
I3 = rho_H_vec==0.4 & N_vec==400;
I4 = rho_H_vec==0.4 & N_vec==100;
plot(h_vec(I),Sm_pi_pi(I),'.--','MarkerSize',30);
plot(h_vec(I2),Sm_pi_pi(I2),'.-','MarkerSize',10);
plot(h_vec(I3),Sm_pi_pi(I3),'.-','MarkerSize',10);
xlabel('h');
grid on;title('\rho_H=0.4');
legend('N=3600','N=900','N=400','N=100','Location','NorthWest');
ylabel('<|z(k=(\pi,\pi))/(h\sigma)|^2>');
set(gca,'FontSize',20);

savefig(h,'simulation-results\magnetic_Bragg_vs_h');
%%
g=figure; 
I = h_vec==0.7 & N_vec==900;
plot(rho_H_vec(I),(psi_vec(I)),'.--','MarkerSize',30);
legend('N=900, h=0.7','Location','NorthWest');
ylabel('|\psi_{14}|');
grid on;
set(gca,'FontSize',20);
xlabel('\rho_H'); 