function [counts, Z_sum] = histXYZ(X, Y, Z, ctrs)
C1 = ctrs{1};
C2 = ctrs{2};

counts = C1'*C2*0;
Z_sum = counts*0;
for i=2:length(C1)
    for j=2:length(C2)
        I = (X>C1(i-1) & X<C1(i)) & (Y>C2(j-1) & Y<C2(j));
        counts(i,j) = sum(I(:));
        Z_sum(i,j) = sum(Z(I(:)));
    end
end

end