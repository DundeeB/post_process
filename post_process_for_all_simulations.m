sim_res_name = 'simulation-results\';
folds = dir(sim_res_name);
for i=1:length(folds)
    if ~folds(i).isdir || sum(strcmp(folds(i).name,...
            {'.','..','Small or 2D simulations'}))
        continue;
    end
    post_process([sim_res_name folds(i).name],false,'output_psi14_b1');
end