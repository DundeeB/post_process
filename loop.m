function all_indices = loop(state, represent_indices, E)
if nargin < 3
    E = knn_based_bonds(state,3);
end
EdgeTable = table(E,'VariableNames',{'EndNodes'});
G = graph(EdgeTable);

r = state.spheres(represent_indices,:);
rcm = mean(r);
dr = r-rcm;
phi = mod(atan2(dr(:,2),dr(:,1)),2*pi);
[~,I] = sort(phi);
r = r(I);
represent_indices = represent_indices(:);
represent_indices = represent_indices(I(:));
represent_indices = [represent_indices; represent_indices(1)];
all_indices = [];
for j=1:length(represent_indices)-1
    P = shortestpath(G,represent_indices(j),represent_indices(j+1));
    all_indices = [all_indices P];
end

end