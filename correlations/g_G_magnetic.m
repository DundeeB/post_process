function [g, rc, counts, g_inf] = g_G_magnetic(state, isplot)
% function [g, rc, counts] = g_G_magnetic(state, G, isplot)
z = (state.spheres(:,3)-state.H/2)/((state.H-2*state.rad)/2);

% sp_xy = state.spheres(:,1:2);
% G = reshape(G,[2 1]);
% psi_G = exp(1i*z*pi/2).*exp(1i*sp_xy*G);

% up = z>0; down = z<0;
% z(up)=z(up)-mean(z(up)); z(down) = z(down)-mean(z(down));
% psi_G = exp(4*pi*1i*z);

psi_G = exp(1i*pi/2*z);

[g, rc, counts] = g_mn(state, psi_G, false);
g_inf = g(end);
g = g-g_inf;
if isplot
    cb = state.cyclic_boundary;
    A = cb(1)*cb(2);
    rhoH = length(state.spheres)/(A*state.H/(2*state.rad)^3);
    lbl = ['N=' num2str(length(state.spheres)) ', h=' num2str(state.H/(2*state.rad)-1) ', \rho_H=' num2str(rhoH)];
    ylabel('g_z(\Deltar)');
    loglog(rc,abs(g)-abs(g_inf),'-','LineWidth',3,'DisplayName', lbl);
    ylabel('g_z(\Deltar)');
    xlabel('\Deltar/\sigma');
    set(gca,'FontSize',20);
    grid on;
    legend();
end
end