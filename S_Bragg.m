function [S] = S_Bragg(k, spheres)
[dk,Nk] = size(k);
[Ns,ds] = size(spheres);
if dk ~= ds
    error('Dimensions of k and spheres disagree');
end
kr = spheres*k;
S = zeros(Nk,1);
for i=1:Nk
    v = exp(1i*kr(:,i));
    S(i) = 1/Ns*abs(sum(sum(v*v')));
end
end
