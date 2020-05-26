function [E_n_double] = clean_doubles(E, N)
[~,I] = sort(E(:,1));
E = E(I,:);
E_n_double = [];
for i=1:N
    bonds_w_i = E(:,1)==i;
    J = E(bonds_w_i,2);
    if isempty(J)
        continue;
    end
    J = sort(J);
    J = [J(~(J(1:end-1)==J(2:end))); J(end)];
    E_n_double = [E_n_double; [ones(size(J))*i J]];
end
end