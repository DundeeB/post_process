function [ b, M_fr, M_fr ] = M_frustration( spheres, nearest_neighbors_cut_off, H, r )
%M_FRUSTRATION is the number of frustrated bonds. As it is not well define
%for our case, we define m_fr(z1,z2) = 1-abs(z1-z2)/(H-2r), which is 1 when
%z1=z2 meaning full frustration, and zero if they are not frustrated,
%meaning the spheres are maximally far away. 
%Then:
%   M_fr = sum(m_fr)
%   M = #bonds
%   b = 1 - M_fr/M

[N, ~] = size(spheres);
M_fr = 0;
M = 0;
for a=1:N
    r1 = spheres(a,:);
    for b = 1:a-1
        r2 = spheres(b,:);
        if norm(r1([1,2])-r2([1,2])) < nearest_neighbors_cut_off
            M = M + 1;
            m = 1 - abs(r1(3) - r2(3))/(H-2*r);
            M_fr = M_fr + m;
        end
    end
end
if M ~= 0
    b = 1 - M_fr/M;
end

end

