function [counts, centers] = zz_correlation(state, N_cuoples_to_hist, centers)
sp = state.spheres;
z = sp(:,3) - state.H/2;
if nargin < 2
    N_cuoples_to_hist = length(sp)^2;
end
zz = zeros(N_cuoples_to_hist, 1);
dr = zeros(N_cuoples_to_hist, 1);
if nargin < 2
    xx = sp(:,1)-sp(:,1)';
    yy = sp(:,2)-sp(:,2)';
    xx = xx(:);
    yy = yy(:);
    dr(:) = sqrt(xx.^2+yy.^2);
    zz = abs(z*z');
    zz = zz(:);
end

if nargin < 3
    centers = [0.1:0.1:2 2.2:0.2:3 3.5:0.5:5 6:50];
end
counts = zeros(size(centers));
centers_w_boundary = [0; centers(:); inf];
for i=2:length(centers_w_boundary)-1
    dX = [1/2*(centers_w_boundary(i)+centers_w_boundary(i-1)) ...
        1/2*(centers_w_boundary(i+1)+centers_w_boundary(i))];
    I = dr>dX(1) & dr<dX(2);
    counts(i-1) = mean(zz(I));
end
end