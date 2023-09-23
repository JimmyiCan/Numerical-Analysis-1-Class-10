function [tf, x] = filter_kernel(t, y, Npts, Norder)
    
% Check that Npts is an odd number
if (mod(Npts, 2) == 0)
    error('Npts must be an odd number!')
end
    
  % Compute number of points to the left & right
Noffset = (Npts-1)/2;

% Initialize output variables
Nx = length(y);
tf = t;
x = zeros(length(tf),1);
% Do fits inside sliding window.
for i = (Noffset+1):(Nx-Noffset)
    start = i-Noffset;
    
    stop = i+Noffset;
    % fprintf('Noffset = %d, i = %d, start = %d, stop = %d, y(i) = %f\n', Noffset, i, start, stop, y(i))
    ysamp = y(start:stop);
    tsamp = t(start:stop)-t(i);  % Center the x axis
    
    % Fit to Nth degree poly using polyfit
    for j = 1:Npts
        for k = 1:Norder+1
            A(j,k) = (tsamp(j)-tsamp((1+Npts)/2)).^(k-1);
        end
    end
    B = inv(A'*A)*A';
    x(i) = B(1,:)*ysamp;
end

  % Deal with ends by padding ends with last computed value on each side.
  %fprintf('----------------------------------------------------------\n')
for i = 1:Noffset
    % fprintf('Noffset = %d, i = %d, Noffset+1 = %d, Nx-Noffset-1 = %d\n', Noffset, i, Noffset+1, Nx-Noffset-1)    
    x(i) = x(Noffset+1);
    x(Nx-i+1) = x(Nx-Noffset-1);
end

end
