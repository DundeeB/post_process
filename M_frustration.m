function [ b1, M_fr, M, N_sp ] = M_frustration( spheres, H, sig, ...
    nearest_neighbors_cut_off, cyclic_boundary)
%M_FRUSTRATION is the number of frustrated bonds. As it is not well define
%for our case, we define m_fr(z1,z2) = 1-abs(z1-z2)/(H-2r), which is 1 when
%z1=z2 meaning full frustration, and zero if they are not frustrated,
%meaning the spheres are maximally far away. 
%Then:
%   M_fr = sum(m_fr)
%   M = #bonds
%   b = 1 - M_fr/M
% For N_sp I choose a cutoff sqrt( sig^2-( (H-sig)/2 )^2 ), which actually
% gives for any bond to be unfrustrated. The key then, is asking how many
% spheres have no bond at all, and so the number of interest then is N_sp/N
% the number of spheres with bond

[N, ~] = size(spheres);

TRI = delaunay(spheres(:,1),spheres(:,2));
[m, ~] = size(TRI);
M_fr = 0;
M = 0;
for i=1:m
    I = TRI(i,:);
    I = [I I(1)];  % add bond I(3) I(1)
    for j=1:3
        r1 = spheres(I(j),:);
        r2 = spheres(I(j+1),:);
        Dxy = norm(r1([1,2])-r2([1,2]));
        if  Dxy < nearest_neighbors_cut_off
    %         m = 1 - 3/2*abs(r1(3) - r2(3))/(H-sig);
            m = (r1(3)-H/2)*(r2(3)-H/2)>=0;  % true = 1 --> frustration
            M_fr = M_fr + m;
            M = M + 1;
        end
    end
end

bonds = zeros(N,N);
Dxy_cr = sqrt( sig^2 - ( (H-sig)/2)^2 );
for i=1:N
    for j=1:i-1
        r1 = spheres(i,:);
        r2 = spheres(j,:);
        Dxy = cyclic_dist(r1([1,2]),r2([1,2]), cyclic_boundary);

        if Dxy <= Dxy_cr
            bonds(i, j) = 1;
            bonds(j, i) = 1;
        end
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
    m = sum(C==i);
    if m>largest_group
        largest_group = m;
    end
end
N_sp = largest_group/N;
end