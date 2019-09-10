father_dir = 'simulation-results\';
% folds_obj = dir(father_dir);
folds_obj = dir([father_dir '*rhoH=0.4']);
sim_dirs = {};
for i=1:length(folds_obj)
    f = folds_obj(i).name;
    if strcmp(f,'.') || strcmp(f,'..')...
            ||strcmp(f,'Small or 2D simulations')||...
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
    rho_H_vec(i) = str2double(regexprep(...
        sim_dirs{i},'.*rhoH=',''));
    N_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'_h=.*',''),'.*N=',''));
    h_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*h=',''),'_rhoH.*',''));
    
%     cd(sim_dirs{i});
    try
%         load('output.mat');
%         psi_vec(i) = psi14(end);
        
%         load('Input_parameters.mat');
        rad = 1;
        a = 2*rad/sqrt(rho_H_vec(i)*(h_vec(i)+1));
        S_convergence = calc_Sm_Bragg_for_lib(sim_dirs{i},pi/a*[1,1]', rad*(h_vec(i)+1));
        Sm_pi_pi(i) = S_convergence(end);
    end
%     cd('../../');
end
%%
% figure; hold all; title('h=0.7');
% I1 = h_vec==0.7 & N_vec==900;
% I2 = h_vec==0.7 & N_vec==3600;
% plot(rho_H_vec(I1),psi_vec(I1),'o--','MarkerSize',10);
% plot(rho_H_vec(I2),psi_vec(I2),'o--','MarkerSize',10);
% legend('N=900','N=3600','Location','NorthWest');
% set(gca,'FontSize',24);
% xlabel('\rho_H');
% ylabel('|\psi_{14}|');
% grid on;
%%
h=figure; hold all; title('\rho_H=0.4');
I1 = rho_H_vec==0.4 & N_vec==900;
I2 = rho_H_vec==0.4 & N_vec==3600;
plot(h_vec(I1),Sm_pi_pi(I1),'o--','MarkerSize',10);
plot(h_vec(I2),Sm_pi_pi(I2),'o--','MarkerSize',10);
legend('N=900','N=3600','Location','NorthWest');
set(gca,'FontSize',24);

xlabel('h');
ylabel('|\psi_{14}|');
grid on;
%%
h=figure; hold all; title('\rho_H=0.4');
I1 = rho_H_vec==0.4 & N_vec==900;
I2 = rho_H_vec==0.4 & N_vec==3600;
plot(h_vec(I1),Sm_pi_pi(I1),'o--','MarkerSize',10);
plot(h_vec(I2),Sm_pi_pi(I2),'o--','MarkerSize',10);
legend('N=900','N=3600','Location','NorthWest');
set(gca,'FontSize',24);
xlabel('h');
ylabel('<|z(k=(\pi,\pi))|^2>');
grid on;
savefig(h,'simulation-results\magnetic_Bragg_vs_h');