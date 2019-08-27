father_dir = 'simulation-results\';
folds_obj = dir(father_dir);
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
psi_vec = zeros(n,1);
for i=1:n
    rho_H_vec(i) = str2double(regexprep(...
        sim_dirs{i},'.*rhoH=',''));
    cd(sim_dirs{i});
    load('output.mat');
    psi_vec(i) = psi14(end);
    cd('../../');
end
figure;
plot(rho_H_vec,psi_vec,'*','MarkerSize',10);
set(gca,'FontSize',24);
xlabel('\rho_H');
ylabel('|\psi_{14}|');
grid on;