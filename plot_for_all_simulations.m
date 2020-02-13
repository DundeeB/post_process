code_dir = pwd;
addpath(code_dir);
father_dir = [pwd '\..\simulation-results\'];
folds_obj = dir(father_dir);
sim_dirs = {};
for i=1:length(folds_obj)
    f = folds_obj(i).name;
    if sum(strcmp(f,{'.','..','Small or 2D simulations'}))||...
            ~isdir([father_dir f]) || ...
            isempty(regexpi(f,'_ECMC'))  % || isempty(regexpi(f,'triang'))
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
%         load('output_psi_frustration100.mat');
        load('output_psi_frustration10.mat');
        b1_vec(i) = b3(end);
        N_sp_vec(i) = N_sp3(end);
        psi14_vec(i) = psi14(end);
        psi23_vec(i) = psi23(end);
    catch err
%         disp(err.message)
    end
end
%%
cd(code_dir);
IN900 = N_vec == 900;
IN3600 = N_vec == 3600;
figure; hold all;
plt = @(I,color)plt_sort_IC(rho_H_vec(I), h_vec(I),IC_vec(I),false,color); 
p3=plt(IN900,'b');
p4=plt(IN3600,'r');
legend([p3 p4],{'900','3600'},'Location','east');
ylim([0 1.1]); 
xlim([0 1.1]);
grid on;
xlabel('\rho_H');ylabel('h');
set(gca,'FontSize',20);

%%
% psi23_vec(isnan(psi23))=0;
% b1_vec(isnan(b1_vec))=1;
j=figure; 
plt_psi23 = @(I,color)plt_sort_IC(rho_H_vec(I),abs(psi23_vec(I)),IC_vec(I), true,color);
plt_psi14 = @(I,color)plt_sort_IC(rho_H_vec(I),abs(psi14_vec(I)),IC_vec(I), true,color);
plt_b1 = @(I,color)plt_sort_IC(rho_H_vec(I),2*b1_vec(I)-1,IC_vec(I), true,color);
plt_N_sp = @(I,color)plt_sort_IC(rho_H_vec(I),N_sp_vec(I),IC_vec(I), true,color);

h = 1;
I900 = h_vec==h & IN900;
I3600 = h_vec==h & IN3600;

hold all;
p23_900  = plt_psi23(I900,'b--');
p14_900  = plt_psi14(I900,'k--');
pb1_900  = plt_b1   (I900,'r--');
pNsp900  = plt_N_sp (I900,'m--');
p23_3600 = plt_psi23(I3600, 'b');
p14_3600 = plt_psi14(I3600, 'k');
pb1_3600 = plt_b1   (I3600,'r');
pNsp3600 = plt_N_sp (I3600,'m');

h_str = ['h=' num2str(h) ', '];
legend([p23_900 p14_900 pb1_900 pNsp900 ...
    p23_3600 p14_3600 pb1_3600 pNsp3600 ],...
    {[h_str 'N=900, |\psi_{23}|'], [h_str 'N=900, |\psi_{14}|'], ...
    [h_str 'N=900, 2*b_{1}-1'], [h_str 'N=900, N_{sp}'], ...
    [h_str 'N=3600, |\psi_{23}|'], [h_str 'N=3600, |\psi_{14}|'], ...
    [h_str 'N=3600, 2*b_{1}-1'], [h_str 'N=3600, N_{sp}']},...
    'Location','NorthWest');

xlabel('\rho_H');
ylabel('Order parameter');
grid on;
set(gca,'FontSize',20);
savefig(j,[code_dir '\graphs\Nsp_psi23_vs_rhoH_h=1']);
cd(code_dir);