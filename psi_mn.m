function [psimn_vec] = psi_mn(m, n, spheres, varargin)
%PSI_N find for the i'th sphere it's nearest neighbors and calculate the
%psi_n order parameter for the i'th sphere
%psi(m,n) is the order parameter 
psimn_vec = zeros(length(spheres),1);
if nargin == 6  % determine nearest neighbors by cutoff
    for a=1:length(psimn_vec)
        psi_n = 0;
        Neighbors = 0;
        r1 = spheres(a,:);
        nearest_neighbors_cut_off = varargin{1};
        H = varargin{2};
        different_heights_cond = varargin{3};
        for b = [1:a-1 a+1:length(spheres)]
            r2 = spheres(b,:);
            if norm(r1([1,2])-r2([1,2])) < nearest_neighbors_cut_off
                if (different_heights_cond && (r1(3)-H/2)*(r2(3)-H/2)>0)
                    continue
                end
                Neighbors = Neighbors + 1;
                dr = r1 - r2;
                t = atan2(dr(2),dr(1));
                psi_n = psi_n + exp(1i*n*t);
            end
        end
        if Neighbors ~= 0
            psi_n = psi_n / Neighbors;
        end
        psimn_vec(a) = abs(psi_n)*exp(1i*m*angle(psi_n));
    end
else  % use delaunay
    if nargin >= 4
        cutoff = varargin{1};
    else
        cutoff = inf;
    end
    [E, ~, spheres] = Edges(spheres, 0, cutoff, []);  % with w=0 BC have no use. 
    psi_n = zeros(size(psimn_vec));
    Neighbors = zeros(size(psimn_vec));
    for i=1:length(E)
        a = E(i,1);
        r1 = spheres(a,:);
        b = E(i,2);
        r2 = spheres(b,:);
        dr = r1 - r2;
        t = atan2(dr(2),dr(1));
        psi_n(a) = psi_n(a) + exp(1i*n*t);
        Neighbors(a) = Neighbors(a) + 1;
        t = atan2(-dr(2),-dr(1));
        psi_n(b) = psi_n(b) + exp(1i*n*t);
        Neighbors(b) = Neighbors(b) + 1;
    end
    I = Neighbors~=0;
    psi_n(I) = psi_n(I)./Neighbors(I);
    for i=1:length(psi_n)
        psimn_vec(i) = abs(psi_n(i))*exp(1i*m*angle(psi_n(i)));
    end
end
end