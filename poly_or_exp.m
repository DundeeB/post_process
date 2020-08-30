function [decision,Rsqs] = poly_or_exp(x,y,isplot)
if nargin==2
    isplot=false;
end
x = x(:); y = y(:);
mdl_loglog = fitlm(log(x), log(y));
mdl_log = fitlm(x, log(y));
Rsqs = [mdl_log.Rsquared.Ordinary mdl_loglog.Rsquared.Ordinary];
if Rsqs(1)>Rsqs(2)
    decision = 'exp';
else
    decision = 'poly';
end
if isplot
    figure; 
    subplot(2,1,1);
    semilogy(x,y,'.-','MarkerSize',24);
    hold on;
    p = polyfit(x,log(y),1);
    semilogy(x, exp(polyval(p,x)));
    legend('data',['exp fit, r^2=' num2str(Rsqs(1))]); 
    grid on;set(gca,'FontSize',20);
    subplot(2,1,2);
    loglog(x,y,'.-','MarkerSize',24);
    hold on;
    p = polyfit(log(x),log(y),1);
    loglog(x, exp(polyval(p,log(x))));
    legend('data',['poly fit, r^2=' num2str(Rsqs(2))]);grid on;set(gca,'FontSize',20);
end
end

