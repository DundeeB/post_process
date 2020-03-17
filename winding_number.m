function [n] = winding_number(indices, psi, spheres)
r = spheres(indices,1:2); 
psi = psi(indices);
rcm = mean(r);
dr = r-rcm;
phi = mod(atan2(dr(:,2),dr(:,1)),2*pi);
[~,I] = sort(phi);
psi = psi(I); 
r = r(I,:);
theta = mod(angle(psi),2*pi);
theta = [theta(:); theta(1)];
n = 0;
for j=1:length(theta)-1
    dt = (theta(j+1)-theta(j))/(2*pi);
    v = dt + [0, 1, -1];
    [~,k] = min(abs(v));
    n = n + v(k);
end
n = round(n);
end