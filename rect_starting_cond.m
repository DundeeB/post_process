function [spheres] = rect_starting_cond(N, box, r)
if length(N) == 2
    n = N(1)*N(2);
else
    n = N(1)*N(2)*N(3);
end
spheres = zeros(n,length(N));
dr = box./N;
if min(abs(dr)) < 2*r
    error('too many spheres');
end
for i=1:N(1)
    for j=1:N(2)
        if length(dr) == 2
            spheres((i-1)*N(2)+j,:) = [i-0.5, j-0.5].*dr;
        else
            for k=1:N(3)
                spheres((i-1)*N(2)*N(3)+(j-1)*N(2)+k,:) = [i-0.5 j-0.5 k-0.5].*dr;
            end
        end
    end
end
end

