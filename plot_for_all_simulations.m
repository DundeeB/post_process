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
N_sp_vec = rho_H_vec;
for i=1:n
    rho_H_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*rhoH=',''),'_.*',''));
    N_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'_h=.*',''),'.*N=',''));
    h_vec(i) = str2double(regexprep(regexprep(...
        sim_dirs{i},'.*h=',''),'_rhoH.*',''));
    
    cd(sim_dirs{i});
    try
        load('output_psi14_psi23_b1_N_sp_20.mat');
        b1_vec(i) = b(end);
        N_sp_vec(i) = N_sp(end);
        psi14_vec(i) = psi14(end);
        psi23_vec(i) = psi23(end);
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
j=figure; 
plt_psi23 = @(I)plot(rho_H_vec(I),abs(psi23_vec(I)),'.','MarkerSize',20);
plt_psi14 = @(I)plot(rho_H_vec(I),abs(psi14_vec(I)),'.','MarkerSize',20);
plt_b1 = @(I)plot(rho_H_vec(I),b1_vec(I),'.','MarkerSize',20);
plt_N_sp = @(I)plot(rho_H_vec(I),N_sp_vec(I),'.','MarkerSize',20);

h = 1;
I1h = h_vec==h & I1N;
I2h = h_vec==h & I2N;
I3h = h_vec==h & I3N;
I4h = h_vec==h & I4N;
subplot(2,1,1); 
hold all;
plt_psi23(I3h)
ylabel('Order parameter');
set(gca,'FontSize',20); grid on;
xlim([0 max(rho_H_vec)]);
hold all;
plt_b1(I3h); plt_N_sp(I3h);
plot([0 1.15],2/3*[1 1],'--','LineWidth',3);
plot([0 1.15],1/2*[1 1],'--','LineWidth',3);
xlabel('\rho_H');
grid on;
set(gca,'FontSize',20);
h_str = ['h=' num2str(h) ', '];
legend([h_str 'N=900, |\psi_{23}|'],[h_str 'N=900, b_1'],[h_str 'N=900, N_{sp}'],...
    'b_1=2/3 same as frustrated triangle','b_1=1/2 completely random',...
    'Location','SouthWest');

h = 0.8;
I1h = h_vec==h & I1N;
I2h = h_vec==h & I2N;
I3h = h_vec==h & I3N;
I4h = h_vec==h & I4N;
subplot(2,1,2); 
hold all;
plt_psi14(I3h);
ylabel('Order parameter');
set(gca,'FontSize',20); grid on;
xlim([0 max(rho_H_vec)]);

hold all;
plt_b1 = @(I)plot(rho_H_vec(I),b1_vec(I),'.','MarkerSize',20);
plt_b1(I3h); plt_N_sp(I3h); 
plot([0 1.15],2/3*[1 1],'--','LineWidth',3);
plot([0 1.15],1/2*[1 1],'--','LineWidth',3);
xlabel('\rho_H');
grid on;
set(gca,'FontSize',20);
h_str = ['h=' num2str(h) ', '];
legend([h_str 'N=900, |\psi_{14}|'],[h_str 'N=900, b_1'],[h_str 'N=900, N_{sp}'],...
    'b_1=2/3 same as frustrated triangle','b_1=1/2 completely random',...
    'Location','SouthWest');
savefig(j,'graphs\b1_N_sp_psi_vs_h');