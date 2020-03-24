function [ b1, M_fr, M, N_sp ] = M_frustration(state, n)
%M_FRUSTRATION is the number of frustrated bonds. We give each sphere a
%charge of +-1, if its in the upper or lower plane. A bond is frustrated
%then if it connect ++ or --, and unfrustrated for +-.
%   M_fr = sum(m_fr)
%   M = #bonds
%   b1 = 1 - M_fr/M
%For N_sp I choose neighbors using a cutoff sqrt( sig^2-( (H-sig)/2 )^2 ),
%which makes any bond unfrustrated. The key then, is asking how many 
%spheres have no bond at all, and so the number of interest then is N_sp/N
%the number of spheres with bond
%   N_sp = #connected spheres in the unfrustated graph
% The input parameter n = #nearest neighbors, 6 for hexagonal, 4 for 
% square, 3 for honeycomn
spheres = state.spheres;

[N, ~] = size(spheres);
bonds = zeros(N,N);
sig = state.rad*2;
Dxy_cr = sqrt( sig^2 - ( (state.H-sig)/2)^2 );
E = knn_based_bonds(state, n);
E = bonds_from_directed_graph(E, state, n);  % delete many bonds
M_fr = 0;
M = 0;
for i=1:length(E)
    r1 = spheres(E(i,1),:);
    r2 = spheres(E(i,2),:);
    m = (r1(3)-state.H/2)*(r2(3)-state.H/2)>=0;  % true = 1 --> frustration
    M_fr = M_fr + m;
    M = M + 1;
    Dxy = norm(r1([1,2])-r2([1,2]));
    if Dxy <= Dxy_cr
        bonds(E(i,1), E(i,2)) = 1;
        bonds(E(i,2), E(i,1)) = 1;
    end
end

if M ~= 0
    b1 = 1 - M_fr/M;
else
    b1 = nan;
    disp('No bond where found');
end

DG = sparse(bonds);
[S, C] = graphconncomp(DG, 'Directed',false);
largest_group = 0;
for i=1:S
    group_size = sum(C==i);
    if group_size>largest_group
        largest_group = group_size;
    end
end
N_sp = largest_group/N;
end