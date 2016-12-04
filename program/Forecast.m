function [ X_50_10 ] = Forecast( X_50, i )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%http://www.mathworks.com/help/econ/forecast-conditional-variances-in-composite-models.html
% % r = X_50(:,i);
% % N = length(r);
% % 
% % model = arima('ARLags',1,'Variance',garch(1,1),...
% %               'Distribution','t');
% % fit = estimate(model,r,'Variance0',{'Constant0',0.001});
% % [E0,V0] = infer(fit,r);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % [Y,YMSE,V] = forecast(fit,10,'Y0',r,'E0',E0,'V0',V0);
% % 
% % X_50_10 = Y;

% r = X_50(:,i);
% 
% na = 1;
% nb = 2;
% sys = armax(r,[na nb]);
% K = 10;
% yp = forecast(sys,r,K);
% X_50_10 = yp;
y = zeros(50,1);

for i = 1:50
    y(i) = X_50(i+1,1);
end

x = [ones(50,1) X_50(1:50,1)];

b = regress(y,x);

X_50_10 = zeros(10,1);
X_50_10(1) = X_50(51,1);
for i = 2:10
    X_50_10(i) = b(1) + b(2)*X_50_10(i-1);
end

end

