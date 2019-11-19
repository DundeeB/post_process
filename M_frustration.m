function [ b1, M_fr, M ] = M_frustration( spheres, H, sig)
%M_FRUSTRATION is the number of frustrated bonds. As it is not well define
%for our case, we define m_fr(z1,z2) = 1-abs(z1-z2)/(H-2r), which is 1 when
%z1=z2 meaning full frustration, and zero if they are not frustrated,
%meaning the spheres are maximally far away. 
%Then:
%   M_fr = sum(m_fr)
%   M = #bonds
%   b = 1 - M_fr/M
TRI = delaunay(spheres(:,1),spheres(:,2));
[N, ~] = size(spheres);
[m, ~] = size(TRI);
M_fr = 0;
M = 0;
for i=1:m
    I = TRI(i,:);
    I = [I I(1)];  % add bond I(3) I(1)
    for j=1:3
        r1 = spheres(I(j),:);
        r2 = spheres(I(j+1),:);
        m = 1 - 3/2*abs(r1(3) - r2(3))/(H-sig);
        M_fr = M_fr + m;
        M = M + 1;
    end
end
if M ~= 0
    b1 = 1 - M_fr/M;
else
    b1 = nan;
    disp('No bond where found');
end

end

