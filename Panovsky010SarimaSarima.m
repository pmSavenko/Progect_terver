clc;
T = readtable('yndx1.csv');
K=235487;
disp(T(1:K,6));
for i=1:K
    X(i)=i;
end;

for i=1:(K-50000)
    X1(i)=i;
end;
open=table2array(T(1:K,2));
close=table2array(T(1:K,3));
close1=table2array(T(1:(K-50000),3));
low=table2array(T(1:K,4));
high=table2array(T(1:K,5));
xx = transpose(X);
xx1 = transpose(X1);
%data = iddata(close1,[]);
data1 = iddata(close,[]);
plot(data1);
figure;
data=close1;
%r=data(1:K-50000,1);
%sys = arima(3,1,2);
%sys=arima(0,0,40);
%sys = arima('Constant',NaN,'ARLags',1:4,'D',0,'MALags',1:4,'SARLags',[12,24,36,48],'Seasonality',12,'SMALags',12,'Distribution','Gaussian');
sys = arima('Constant',NaN,'ARLags',1:4,'D',0,'MALags',1:4,'SARLags',1:10,'Seasonality',12,'SMALags',12,'Distribution','Gaussian');
Md1 = estimate(sys,data);
yf = forecast(Md1,50000,'Y0',data);
figure;
plot(1:length(data),data,'b',length(data):length(data)+length(yf),[data(end);yf],'r'), legend('measured','forecasted')

%sys = ar(data,6,'ls');
%opt = forecastOptions('InitialCondition','z');
%K = 50000;
%p = forecast(sys,data,K,opt);
%plot(data,'b',p,'r', data1,'g'), legend('measured','forecasted','real')

%plot(data,'b',p,'r', data1,'g'), legend('measured','forecasted','real')

%plot(data,'b',p,'r', data1,'g'), legend('measured','forecasted','real')

%save('mymat.mat','close','xx');