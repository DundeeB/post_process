function [] = histogram_dislocations(sim_path, method, pair_couples)
load([sim_path '\Input_parameters_from_python.mat']);  % Lx Ly H
figure;
N = rho_H/8*Lx*Ly*H;
unit_lattice = sqrt(Lx*Ly/N);
b_magnitude = sort([1 sqrt(2) 2 sqrt(5) sqrt(8) 3 sqrt(10) sqrt(13) sqrt(18) 4]);
eq = @(x1,x2) abs(x1-x2)<1e-4;
n_ = @(l, B) sum(eq(sqrt(B(:,1).^2+B(:,2).^2)/unit_lattice,l))/length(B);

if strcmp(method,'grid')
    rads = 1:1:40;
    n_arr = zeros(length(rads),length(b_magnitude));
    for i=1:length(rads)
        [B, R] = collapse_burger(sim_path, rads(i), false, false, pair_couples);
        for j=1:length(b_magnitude)
            n_arr(i,j) = n_(b_magnitude(j), B);
        end
    end
    plot(rads,[n_arr sum(n_arr')'],'.-','MarkerSize',10,'LineWidth',1.5);
    xlabel('a');
end

if strcmp(method,'k_means')
    [burg, sp, boundaries] = visualize_burger(sim_path, false);
    if pair_couples
        [b,r] = nearest_neighbor_coarse_graining(sim_path,false,false);
        burg = [r b];
    end
    k_max = length(burg);
    dk = round(k_max/30);
    ks = dk:dk:k_max;
    n_arr = zeros(length(ks),length(b_magnitude));
    for i=1:length(ks)
        [B, R] = k_coarse_grain(sim_path,ks(i),false,false, pair_couples);
        for j=1:length(b_magnitude)
            n_arr(i,j) = n_(b_magnitude(j), B);
        end
    end
    plot(ks,[n_arr sum(n_arr')'],'.-','MarkerSize',10,'LineWidth',1.5);
    xlabel('k');
end

if strcmp(method,'annihilation')
    rads = 5:5:40;
    n_arr = zeros(length(rads),length(b_magnitude));
    for i=1:length(rads)
        [B, R] = annihilate_coarse_grain(sim_path, rads(i), false);
        for j=1:length(b_magnitude)
            n_arr(i,j) = n_(b_magnitude(j), B);
        end
    end
    plot(rads,[n_arr sum(n_arr')'],'.-','MarkerSize',10,'LineWidth',1.5);
    xlabel('rad for annhilliation');
end

ylabel('% of dislocation');
legends = {};
for b=b_magnitude
    legends{end+1} = num2str(b);
end
legends{end+1} = 'tot';
legend(legends);
set(gca,'fontsize',20);
grid on;
end