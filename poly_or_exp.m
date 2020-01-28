function [decision,Rsqs] = poly_or_exp(x,y)
x = x(:); y = y(:);
mdl_loglog = fitlm(log(x), log(y));
mdl_log = fitlm(x, log(y));
Rsqs = [mdl_log.Rsquared.Ordinary mdl_loglog.Rsquared.Ordinary];
if Rsqs(1)>Rsqs(2)
    decision = 'exp';
else
    decision = 'poly';
end

