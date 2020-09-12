function [] = histogram_dislocations(sim_path)
as = 1:1:40;
load([sim_path '\Input_parameters_from_python.mat']);  % Lx Ly H
N = rho_H/8*Lx*Ly*H;
unit_lattice = sqrt(Lx*Ly/N);
b_magnitude = sort([1 sqrt(2) 2 sqrt(5) sqrt(8) 3 sqrt(10) sqrt(13) sqrt(18) 4]);
n_arr = zeros(length(as),length(b_magnitude));
for i=1:length(as)
    [B, R] = collapse_burger(sim_path, as(i), false);
    N = length(B);
    eq = @(x1,x2) abs(x1-x2)<1e-4;
    n_ = @(l) sum(eq(sqrt(B(:,1).^2+B(:,2).^2)/unit_lattice,l))/N;
    for j=1:length(b_magnitude)
        n_arr(i,j) = n_(b_magnitude(j));
    end
end
plot(as,[n_arr sum(n_arr')'],'.-','MarkerSize',10,'LineWidth',1.5);
xlabel('a');
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