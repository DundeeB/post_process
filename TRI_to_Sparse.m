function [ DG ] = TRI_to_Sparse( TRI )
%TRI_TO_SPARSE Summary of this function goes here
%   Detailed explanation goes here
[n,~] = size(TRI);
TRI = [TRI TRI(:,1)];
A = zeros(n,n);
for i = 1:n
    for j=1:3
        A(TRI(i,j),TRI(i,j+1)) = 1;
        A(TRI(i,j+1),TRI(i,j)) = 1;
    end
end
DG = sparse(A);

end

