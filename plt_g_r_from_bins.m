function [] = plt_g_r_from_bins(Nbins, Centers, L, t)
N = round(sqrt(sum(Nbins(:))));
[X,Y] = meshgrid(Centers{1},Centers{2});
xij = zeros(N^2,1);
yij = zeros(N^2,1);
N1 = length(Centers{1});
N2 = length(Centers{2});
ind = 0;
for i=1:N1
    for j=1:N2
        N3 = round(Nbins(i,j));
        for k=1:N3
            ind = ind + 1;
            xij(ind) = X(i,j);
            yij(ind) = Y(i,j);
        end
    end
end
xij = reshape(xij,[N N]);
yij = reshape(yij,[N N]);
plt_g_r(xij, yij, L, t);
end