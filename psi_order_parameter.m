function [psimn_avg] = psi_order_parameter(m, n, spheres, varargin)
%psi(m,n) 
% n = #number of neighbers in order phase.  
% m = #symmetry/n
% for example, in the honeycomb lattice we have 3 neighbors and the
% symmetry is 6, so n=2 and m=3.
psimn = psi_mn(m, n, spheres, varargin{:});
I = psimn~=0;
if isempty(I)
    psimn_avg = nan;
    return;
end
psimn = psimn(I);
psimn_avg = sum(psimn)/length(psimn);
end