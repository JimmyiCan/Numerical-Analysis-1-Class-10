function test_my_savitzky_golay_filter()
[tf, yf, d2f] = my_savitzky_golay_filter();
s = length(tf);
yf_true = 6*ones(s,1);
tol = 3.4;
for i = 1:s
    if(abs(yf_true(i) - yf(i)) >= tol)
        error('Error of savitzky golay is too big!')
    end
end
disp('Error of savitzky golay is small.')

for i = 1:s
    if(abs(yf_true(i) - d2f(i)) >= tol)
        error('Error of finite difference is too big!')
    end
end
disp('Error of finite difference is too big')
