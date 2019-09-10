sim_res_name = 'simulation-results\';
folds = dir(sim_res_name);
for i=1:length(folds)
    if ~folds(i).isdir || sum(strcmp(folds(1).name,{'.','..'}))
        continue;
    end
    post_process([sim_res_name folds(i).name],false,'output');
end