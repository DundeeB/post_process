function [] = plt_g_r_from_bins(Nbins, Centers, L, t)
Nsq = sum(Nbins(:));
N = round(sqrt(Nsq));
Nbins = Nbins * N^2/Nsq;
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
            xij(ind) = X(j,i);
%             xij(ind) = Centers{1}(i);
            yij(ind) = Y(j,i);
%             yij(ind) = Centers{2}(j);
        end
    end
end
xij = reshape(xij,[N N]);
yij = reshape(yij,[N N]);
plt_g_r(xij, yij, L, t);
end