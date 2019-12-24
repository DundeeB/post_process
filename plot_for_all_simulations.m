code_dir = pwd;
addpath(code_dir);
father_dir = 'C:\Users\Daniel\OneDrive - Technion\simulation-results\';
folds_obj = dir(father_dir);
sim_dirs = {};
for i=1:length(folds_obj)
    f = folds_obj(i).name;
    if sum(strcmp(f,{'.','..','Small or 2D simulations'}))||...
            ~isdir([father_dir f])  
        continue
    end
    sim_dirs{end+1} = [father_dir f];
end
n = length(sim_dirs);
rho_H_vec = zeros(n,1)*nan;
h_vec = rho_H_vec;
N_vec = rho_H_vec;
psi14_vec = rho_H_vec;
psi23_vec = rho_H_vec;
Sm_pi_pi = rho_H_vec;
b1_vec = rho_H_vec;
N_sp_vec = rho_H_vec;
IC_vec = [{}];
for i=1:n
    rho_H_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*rhoH=',''),'_.*',''));
    N_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'_h=.*',''),'.*N=',''));
    h_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*h=',''),'_rhoH.*',''));
    IC_vec(end+1) = {regexprep(sim_dirs{i},'.*rhoH=[0-9][\.]?[0-9]*_?','')};
    if strcmp(IC_vec(end),'')
        IC_vec(end) = {'square'};
    end
    cd(sim_dirs{i});
    try
        load('output_psi14_psi23_b1_N_sp_100.mat');
        b1_vec(i) = b(end);
        N_sp_vec(i) = N_sp(end);
        psi14_vec(i) = psi14(end);
        psi23_vec(i) = psi23(end);
    catch err
%         disp(err.message)
    end
    cd('../../');
end
%%
I1N = N_vec == 100;
I2N = N_vec == 400;
I3N = N_vec == 900;
I4N = N_vec == 3600;
figure; hold all;
plt = @(I,color)plt_sort_IC(rho_H_vec(I), h_vec(I),IC_vec(I),false,color); 
p1=plt(I1N,'Black');p2=plt(I2N,'m');p3=plt(I3N,'b');p4=plt(I4N,'r');
legend([p1 p2 p3 p4],{'100','400','900','3600'},'Location','east');
xlim([0 max(rho_H_vec)]);
ylim([0 1.1]); grid on;
xlabel('\rho_H');ylabel('h');
set(gca,'FontSize',20);

%%
j=figure; 
plt_psi23 = @(I,color)plt_sort_IC(rho_H_vec(I),abs(psi23_vec(I)),IC_vec(I), true,color);
plt_psi14 = @(I,color)plt_sort_IC(rho_H_vec(I),abs(psi14_vec(I)),IC_vec(I), true,color);
plt_b1 = @(I,color)plt_sort_IC(rho_H_vec(I),b1_vec(I),IC_vec(I), true,color);
plt_N_sp = @(I,color)plt_sort_IC(rho_H_vec(I),N_sp_vec(I),IC_vec(I), true,color);

h = 1;
I1h = h_vec==h & I1N;
I2h = h_vec==h & I2N;
I3h = h_vec==h & I3N;
I4h = h_vec==h & I4N;
hold all;
p23_400 = plt_psi23(I2h, 'm--');
p23 = plt_psi23(I3h,'b--');
p23_36 = plt_psi23(I4h, 'r--');
ylabel('Order parameter');
set(gca,'FontSize',20); grid on;
xlim([0 max(rho_H_vec)]);
hold all;
p_Nsp400 = plt_N_sp(I2h,'m');
p_Nsp = plt_N_sp(I3h,'b');
p_Nsp36 = plt_N_sp(I4h,'r');
xlabel('\rho_H');
grid on;
set(gca,'FontSize',20);
h_str = ['h=' num2str(h) ', '];
legend([p23_400 p23 p23_36 p_Nsp400 p_Nsp p_Nsp36],...
    {[h_str 'N=400 |\psi_{23}|'], [h_str 'N=900, |\psi_{23}|'],[h_str 'N=3600, |\psi_{23}|']...
    [h_str 'N=400, N_{sp}'], [h_str 'N=900, N_{sp}'], [h_str 'N=3600, N_{sp}']},...
    'Location','NorthWest');

savefig(j,[code_dir '\graphs\Nsp_psi23_vs_rhoH_h=1']);
cd(code_dir);