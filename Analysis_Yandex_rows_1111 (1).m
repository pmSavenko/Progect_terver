T = readtable('yndx1.csv');

K=235487;
disp(T(1:K,6));
for i=1:K
    X(i)=i;
end;
open=table2array(T(1:K,2));
close=table2array(T(1:K,3));
low=table2array(T(1:K,4));
high=table2array(T(1:K,5));
plot(X(1:K),open(1:K), X(1:K), close(1:K), X(1:K), low(1:K), X(1:K), high(1:K));
legend('стоимость на момент открытия','стоимость на момент закрытия','минимальная стоимость акций','максимальная стоимость акций','Location','northwest');
xx = transpose(X);
p0 = polyfit(xx,close,0)
p1 = polyfit(xx,close,1)
p2 = polyfit(xx,close,2)
p3 = polyfit(xx,close,3)
p4 = polyfit(xx,close,4)
p5 = polyfit(xx,close,5)
p6 = polyfit(xx,close,6)

f0 = polyval(p0, xx);
f1 = polyval(p1, xx);
f2 = polyval(p2, xx);
f3 = polyval(p3, xx);
f4 = polyval(p4, xx);
f5 = polyval(p5, xx);
f6 = polyval(p6, xx);
figure;
plot(xx, close, xx, f1, 'r ')
title('Построение линейного тренда')
legend('Исходные данные о стоимости на момент закрытия','Линейный тренд')
figure;
plot(xx, close, xx, f0, 'y ', xx, f1, 'k ', xx, f2, 'g ',xx, f3, 'r -',xx, f4, 'c ',xx, f5, 'b ', xx, f6, 'm ')
title('Построение полиномов с помощью МНК')
legend('Исходные данные о стоимости на момент закрытия','Полином 0-й степени','Полином 1-й степени','Полином 2-й степени','Полином 3-й степени','Полином 4-й степени','Полином 5-й степени','Полином 6-й степени','location','northeastoutside')
figure;
kk = 1; j = 1; summary=0; counter=0;
for i=1:length(close)  
    x1(j) = xx(i);
    y1(j)= close(i);
    j = j+1;
    if i == kk*10000
         xi = [((kk*10000)-9999):0.5:(kk*10000)];
%         pp1 = polyfit(x1,y1,1);
%         fa1 = polyval(pp1, xi);
        
%         plot(xi, fa1)
%         cftool(x1, y1)
%         cs = csapi(x1, y1);
%         fnplt(cs, 2);
       % yi = interp1(x1,y1,xi, 'linear');
        yi = spline(x1,y1,xi);
       
        plot(xi, yi)


        for k=1:length(y1)
        summary=summary+abs(yi(k)-y1(k));
        counter=counter+1;
        end;
        hold on
        j = 1; 
        kk = kk+1;
        x1=[]; y1=[];
    end;
end;

ErrorCount=summary/counter;

% xi = [((kk*1000)-999):0.5:(i-kk*1000)];
% yi = spline (x1, y1, xi);
% hold on
% plot(xi, yi)
% % xi = [x1(1):0.5:x1(length(x1))];
% 
% yi = spline (x1, y1, xi);
% figure;
% plot(xi, yi)