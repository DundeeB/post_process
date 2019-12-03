father_dir = 'C:\Users\Daniel\OneDrive - Technion\simulation-results\';
folds = dir(father_dir);
for i=1:length(folds)
    if ~folds(i).isdir || sum(strcmp(folds(i).name,...
            {'.','..','Small or 2D simulations'}))
        continue;
    end
    post_process([father_dir folds(i).name],false,'output_psi14_b1');
end