function [Sm] = Sm_Bragg(k, spheres, z0)
[dk,Nk] = size(k);
[Ns,ds] = size(spheres);
if dk ~= ds-1
    error('Dimensions of k and spheres disagree must be -1 in the case of magnetic bragg');
end
r = spheres(:,1:2);
z = spheres(:,3)-z0;
kr = r*k;
Sm = zeros(Nk,1);
for i=1:Nk
    v = z.*exp(1i*kr(:,i));
    Sm(i) = abs(1/Ns^2*sum(sum(v*v')));
end
end
