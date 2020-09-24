function [burg, sp, boundaries] = visualize_burger(sim_path, is_plot)
burger_files = dir([sim_path '/OP/burger_vectors/vec_*.txt']);
is = [];
for i=1:length(burger_files)
    is(end+1)=str2double(regexprep(regexprep(burger_files(i).name,'vec_',''),'.txt',''));
end
[i,j] = max(is);
burg = dlmread([burger_files(j).folder '\' burger_files(j).name]);
sp = dlmread([sim_path '/' num2str(i)]);

load([sim_path '\Input_parameters_from_python.mat']);  % Lx Ly H
boundaries = [Lx Ly H];
if nargin>1 && ~is_plot
    return
end
hold all; axis equal;xlim([0 Lx]); ylim([0 Ly]);
TRI = delaunay(sp(:,1),sp(:,2));
% triplot(TRI,sp(:,1),sp(:,2));
up = sp(:,3)>H/2;
plot(sp(up,1),sp(up,2),'.k','markersize',5);
plot(sp(~up,1),sp(~up,2),'.m','markersize',5);
quiver(burg(:,1),burg(:,2),burg(:,3),burg(:,4),0,'r','LineWidth',1);
% plot(burg(:,1),burg(:,2),'+r','linewidth',2);



end