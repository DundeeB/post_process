function [spheres] = rect_starting_cond(N, box)
if length(N) == 2
    n = N(1)*N(2);
else
    n = N(1)*N(2)*N(3);
end
spheres = zeros(n,length(N));
dr = box./(N+1);
for i=1:N(1)
    for j=1:N(2)
        if length(dr) == 2
            spheres((i-1)*N(2)+j,:) = [i,j].*dr;
        else
            for k=1:N(3)
                spheres((i-1)*N(1)+(j-1)*N(2)+k,:) = [i j k].*dr;
            end
        end
    end
end
end

