function [spheres] = antiferro_rect_starting_cond3D(N, box, r)
n = N(1)*N(2);
if length(N) ~= 2
    assert(N(3) == 1);
end
spheres = zeros(n,length(N));
dr = box./N;
for i=1:N(1)
    for j=1:N(2)
        if length(box) == 2
            spheres((i-1)*N(2)+j,:) = [i-0.5, j-0.5].*dr;
        else
            if mod(i+j,2) == 0
                z = r*1.001;
            else
                z = box(3) - r*1.001;
            end
            spheres((i-1)*N(2)+j,:) = [[i-0.5, j-0.5].*dr(1:2) z];
        end
    end
end
end

