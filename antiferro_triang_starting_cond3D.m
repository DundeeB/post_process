function [spheres] = antiferro_triang_starting_cond3D(N, box, r)
n = N(1)*N(2);
if length(N) ~= 2
    assert(N(3) == 1);
end
assert(round(N(2)/2)==N(2)/2,'N(2)=n_row should be even for antiferro trian Initial conditions');
N_ = [N(1) N(2)/2 N(3)];
ay = 2*box(2)/N(2);
spheres_down = ferro_triang_starting_cond3D(N_, box, r);  % N = [n_col n_row 1]
spheres_up   = ferro_triang_starting_cond3D(N_, box, r);
spheres_up(:,3) = box(3) - spheres_up(:,3);
spheres_up(:,2) = spheres_up(:,2) + ay*2/3;
spheres_up = cyclic(spheres_up,box);

spheres = [spheres_down ; spheres_up];
end