function [tf, yf, d2f] = my_savitzky_golay_filter()
clear;
close;
T = readtable('noisy_parabola.csv');
T = T{:,:};
t = T(:,1);
y = T(:,2);
Npts = 7;
Norder = 2;
[tf, yf] = savitzky_golay_filter(t, y, Npts, Norder);
yf = yf(:,1).*2;
disp([tf yf])

% Finite difference
s = length(T(:,1));
d2f = zeros(s,1);
for i = 2:s-1
    d2f(i) = (T(i+1,2) - 2*T(i,2) + T(i-1,2))/((T(i,1) - T(i-1,1)).^2);
end
d2f(1) = d2f(2);
d2f(s) = d2f(s-1);

plot(tf,yf,'r')
hold on
plot(tf,d2f,'b')
legend('Savitzky Golay','Finite difference')
xlabel('t')
ylabel('d2y')
title('Computed moving second derivatives')
disp(d2f)
