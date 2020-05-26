function [E, h] = bonds_from_directed_graph(E_d, state, n, isplot)
if nargin<=3 
    isplot = false;
end
for i=1:length(E_d)
    E_d(i,:) = sort(E_d(i,:));
end
[~,I] = sort(E_d(:,1));
E_d = E_d(I,:);
sp = state.spheres;

A = zeros(length(sp));
for i=1:length(E_d)
    A(E_d(i,1),E_d(i,2))=1;
end

for i=1:length(sp)
    J1 = find(A(i,:) == 1);
    A(i, J1) = 0;
    J2 = find(A(:,i) == 1);
    A(J2, i) = 0;
    J = unique([J1(:); J2(:)]);
    dist = zeros(size(J));
    for j=1:length(J)
        e = [i J(j)];
        dist(j) = d(e,state);
    end
    [~,JJ] = sort(dist);
    l = min(n,length(JJ));
    J = J(JJ(1:l));
    for j=J
        A(i,j) = 1;
    end
end

E = [];
for i=1:length(A)
    for j=1:length(A)
        if A(i,j) == 1
            E = [E; i j];
        end
    end
end

if isplot
    h=figure; 
    hold on;
    sig = 2*state.rad;
    for i=1:length(E)
        r = sp(E(i,:),:);
        if norm(r(1,1:2)-r(2,1:2))<10
            frust = (r(1,3)-state.H/2)*(r(2,3)-state.H/2)>0;
            if frust
                color = 'red';
            else
                color = 'c';
            end
            plot(r(:,1)/sig,r(:,2)/sig,['-' color],'LineWidth',1.5);
        end
    end
    up = sp(:,3)>state.H/2;
    down = ~up;
    plot(sp(up,1)/sig,sp(up,2)/sig,'.k','MarkerSize',5);
    plot(sp(down,1)/sig,sp(down,2)/sig,'.m','MarkerSize',5);
    xlabel('x/\sigma');
    ylabel('y/\sigma');
    axis equal;
    set(gca,'FontSize',20);
end    
end
function dist = d(e,state)
    dist = cyclic_dist(state.spheres(e(1),1:2),state.spheres(e(2),1:2),...
        state.cyclic_boundary);
end