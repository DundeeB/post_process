function [g, rc, counts] = g_mn(state, psi, isplot)
sp = state.spheres(:,1:2)/(2*state.rad); 
cb = state.cyclic_boundary/(2*state.rad);
h = state.H/(2*state.rad)-1;

xij = sp(:,1)-sp(:,1)';
yij = sp(:,2)-sp(:,2)';
rij_vec = cyclic_vec([xij(:) yij(:)], cb);
% rij_vec = [xij(:) yij(:)];
rij = sqrt(rij_vec(:,1).^2+rij_vec(:,2).^2);
psipsi = psi*psi'; psipsi = psipsi(:);

rmax = min(cb)/2;
r = ([0:0.1:rmax])';
rc = r(1:end-1)+diff(r)/2;
g = zeros(size(rc));
counts = zeros(size(rc));
for i=1:length(rc)
    I = rij>r(i) & rij<r(i+1);
    g(i) = mean(psipsi(I));
    counts(i) = sum(I);
end
if nargin > 2 && isplot
    A = cb(1)*cb(2);
    rhoH = length(sp)/(A*(h+1));
    lbl = ['N=' num2str(length(sp)) ', h=' num2str(h) ', \rho_H=' num2str(rhoH)];
    
    loglog(rc,abs(g),'-','LineWidth',3,'DisplayName', lbl);
    ylabel('g_{mn}(r)');
    xlabel('\Deltar/\sigma');
    set(gca,'FontSize',20);
    grid on;
    legend();
end
end