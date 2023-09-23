close
clear

% To compute
a = ones(10,1);
t = [1600:50:1900 1920:20:1960];
t = t';
A = [a -t];
y = [500 545 623 728 906 1171 1608 1834 2295 3003];
y = 1./y';
x = inv(A'*A)*A'*y;
t0 = x(1)/x(2);
k = x(2);
fprintf('t0 = %f, k = %f\n',t0,k)
plot(t,y,'bo')
hold on
T = 1600:1:1960;
f = k*(t0 - T);
plot(T,f,'r')
t1 = 1980:10:2020;
t1 = t1';
y1 = [4458 5327 6143 6956 7794];
y1 = 1./y1';
T1 = 1980:1:2020;
f1 = k*(t0 - T1);
plot(t1,y1,'bo')
plot(T1,f1,'r')
xlabel('Time')
ylabel('y = 1/Population')
legend('Actual value','Simulation')
hold off



% To test
n = norm(A*x - y);
N = n.*ones(length(n),1e4);
for i = 1:1e3
    m = norm(A*(x-rand(length(x),1)));
    if (m < n)
        error('x is not the best solution.\n')
    end
end
disp('x is the best solution.')

