function [wraped_sp] = wrap_sp_with_periodic_bd(sp,BD)
Lx = BD(1); Ly = BD(2);
x = sp(:,1); y = sp(:,2);
w = 6;
sp1 = sp(x-Lx>-w &     y<w,:) + [-Lx  Ly 0];
sp2 = sp(              y<w,:) + [  0  Ly 0];
sp3 = sp(x<w     &     y<w,:) + [ Lx  Ly 0];
sp4 = sp(x-Lx>-w          ,:) + [-Lx   0 0];
sp5 = sp(                :,:) + [  0   0 0];
sp6 = sp(x<w              ,:) + [ Lx   0 0];
sp7 = sp(x-Lx>-w & y-Ly>-w,:) + [-Lx -Ly 0];
sp8 = sp(          y-Ly>-w,:) + [  0 -Ly 0];
sp9 = sp(x<w     & y-Ly>-w,:) + [ Lx -Ly 0];
wraped_sp = [sp1;sp2;sp3;sp4;sp5;sp6;sp7;sp8;sp9];
end