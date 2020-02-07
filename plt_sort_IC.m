function [p] = plt_sort_IC(x,y,IC,wl,color)
%PLT_SORT_IC Summary of this function goes here
%   Detailed explanation goes here
Inan = ~(isnan(x) | isnan(y));
x = x(Inan);y = y(Inan);IC = IC(Inan);

hold on;

[~,I] = sort(x);
if wl
    p = plot(x(I), y(I),color,'LineWidth',2);
else
    p = plot(x(I), y(I),['.' color],'MarkerSize',20);
end

IC_pool = {'square','triangle','AF_triangle','AF_triangle_ECMC'};
for i=1:length(x)
    switch IC{i}
        case IC_pool{1}
            plot(x(i), y(i),['s' color],'MarkerSize',15,'LineWidth',2); 
        case IC_pool{2}
            plot(x(i), y(i),['^' color],'MarkerSize',15,'LineWidth',2); 
        case IC_pool{3}
            plot(x(i), y(i),['v' color],'MarkerSize',15,'LineWidth',2); 
        case IC_pool{4}
            plot(x(i), y(i),['v' color],'MarkerSize',15,'LineWidth',2);         
    end
end
end

