function test_filter_kernel_vs_sg()
close;
clear;
T = readtable('noisy_parabola.csv');
T = T{:,:};
t = T(:,1);
y = T(:,2);
Npts = 7;
Norder = 2;
[~, x] = filter_kernel(t, y, Npts, Norder);
[~, yf] = savitzky_golay_filter(t, y, Npts, Norder);
yf = yf(:,3);
n = x - yf;
disp(size(x))
disp(size(yf))
disp(x(60))
disp(yf(60))
tol = 1e-3;
if (n > tol)
    error('Error is too big!')
else
    disp('true')
end