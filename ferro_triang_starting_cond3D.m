function [spheres] = ferro_triang_starting_cond3D(N, box, r)
n = N(1)*N(2);
if length(N) ~= 2
    assert(N(3) == 1);
end
spheres = zeros(n,length(N));
ax = box(1)/(N(1)+1/2);
ay = box(2)/(N(2)+1);%*sin(pi/3);
assert(ax>=2*r && ay/cos(pi/6)>=2*r, "ferro triangle initial conditions are not defined for a<2*r, too many spheres");
for i=1:N(2)  % N = [n_col n_row 1]
    for j=1:N(1)
        if mod(i,2) == 1
            xj = 1.001*r + ax*(j-1);  % cos(pi/3)=1/2
        else
            xj = 1.001*r + ax*(j-1+1/2);
        end
        yi = 1.001*r + ay*(i-1);
        spheres((i-1)*N(1)+j,:) = [xj yi r*1.001];
    end
end
end

