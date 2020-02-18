function [rs peaks] = get_peaks(g, r, noise, window, isplot)
% Find peaks in g(r)
orig_g = g; orig_r = r;
I = g>noise;
g = g(I); r=r(I);
rs = [];
peaks = [];
while ~isempty(g)
    [p,i] = max(g);
    peaks(end+1) = p;
    rs(end+1) = r(i);
    I = (r < r(i)-window/2) | (r > r(i)+window/2);
    r = r(I); g = g(I);
end
[~,I] = sort(rs); rs=rs(I); peaks=peaks(I);
if nargin>4 && isplot
    figure;
    plot(orig_r, orig_g,'.-b','MarkerSize',20);
    hold all;
    for i=1:length(rs)
        plot(rs(i)*[1 1], [0 peaks(i)],'-k','LineWidth',2);
    end
    set(gca,'FontSize',20);
    xlabel('\Deltar');
    ylabel('g(r)');
    legend('signal','chosen peaks');
    grid on;
end
end