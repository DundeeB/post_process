lx = 100; ly = 100;r=1;
nx = 50; ny = 18;
ax = lx/(nx+1/2);
ay = ly/(ny+1);
a = min(ax,ay);
% ax = a; ay = a;
sp = [];
for i=1:ny
    for j=1:nx
        if mod(i,2)==0
            xj = r+ax*j;
        else
            xj = r+ ax*(j+1/2);
        end
        yi = r+i*ay;
        sp = [sp; xj yi];
    end
end
plot(sp(:,1),sp(:,2),'.');
grid on;
% axis equal;
xlim([0 lx]);ylim([0 ly]);