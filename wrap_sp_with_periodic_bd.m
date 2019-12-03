function [wraped_sp] = wrap_sp_with_periodic_bd(sp,BD)
Lx = BD(1); Ly = BD(2);
sp1 = sp(:,:) + [-Lx  Ly 0];
sp2 = sp(:,:) + [  0  Ly 0];
sp3 = sp(:,:) + [ Lx  Ly 0];
sp4 = sp(:,:) + [-Lx   0 0];
sp5 = sp(:,:) + [  0   0 0];
sp6 = sp(:,:) + [ Lx   0 0];
sp7 = sp(:,:) + [-Lx -Ly 0];
sp8 = sp(:,:) + [  0 -Ly 0];
sp9 = sp(:,:) + [ Lx -Ly 0];
wraped_sp = [sp1;sp2;sp3;sp4;sp5;sp6;sp7;sp8;sp9];
end