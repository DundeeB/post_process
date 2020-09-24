function [] = histogram_dislocations(sim_path, grid_or_k_means)
load([sim_path '\Input_parameters_from_python.mat']);  % Lx Ly H
N = rho_H/8*Lx*Ly*H;
unit_lattice = sqrt(Lx*Ly/N);
b_magnitude = sort([1 sqrt(2) 2 sqrt(5) sqrt(8) 3 sqrt(10) sqrt(13) sqrt(18) 4]);
eq = @(x1,x2) abs(x1-x2)<1e-4;
n_ = @(l, B) sum(eq(sqrt(B(:,1).^2+B(:,2).^2)/unit_lattice,l))/length(B);
if strcmp(grid_or_k_means,'grid')
    as = 1:1:40;
    n_arr = zeros(length(as),length(b_magnitude));
    for i=1:length(as)
        [B, R] = collapse_burger(sim_path, as(i), false);
        for j=1:length(b_magnitude)
            n_arr(i,j) = n_(b_magnitude(j), B);
        end
    end
    plot(as,[n_arr sum(n_arr')'],'.-','MarkerSize',10,'LineWidth',1.5);
    xlabel('a');
end
if strcmp(grid_or_k_means,'k_means')
    [burg, sp, boundaries] = visualize_burger(sim_path, false);
    k_max = length(burg);
    dk = round(k_max/30);
    ks = dk:dk:k_max;
    n_arr = zeros(length(ks),length(b_magnitude));
    for i=1:length(ks)
        [B, R] = coarse_grain_burger_k_means(sim_path,ks(i),false,false);
        for j=1:length(b_magnitude)
            n_arr(i,j) = n_(b_magnitude(j), B);
        end
    end
    plot(ks,[n_arr sum(n_arr')'],'.-','MarkerSize',10,'LineWidth',1.5);
    xlabel('k');
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