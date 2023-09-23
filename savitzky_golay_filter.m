function [tf, yf] = savitzky_golay_filter(t, y, Npts, Norder)
  % Performs Savitzky Golay filter over input spectrum y.
  % Npts is number of points to use in poly fitting.
  % Norder is the order of the poly used to fit (usually 2 or 4).
  % This fcn repeats (inefficiently) the poly interpolation over
  % each subset of pts.
    
  % Check that Npts is an odd number
  if (mod(Npts, 2) == 0)
    error('Npts must be an odd number!')
  end
    
  % Compute number of points to the left & right
  Noffset = (Npts-1)/2;

  % Initialize output variables
  Nx = length(y);
  yf = zeros(Nx, Norder+1);
  tf = t;

  % Do fits inside sliding window.
  for i = (Noffset+1):(Nx-Noffset)
    start = i-Noffset;
    stop = i+Noffset;
    % fprintf('Noffset = %d, i = %d, start = %d, stop = %d, y(i) = %f\n', Noffset, i, start, stop, y(i))
    ysamp = y(start:stop);
    tsamp = t(start:stop)-t(i);  % Center the x axis
    
    % Fit to Nth degree poly using polyfit
    P = polyfit(tsamp, ysamp, Norder);
    % Decreasing order, constant term is P(end)
    yf(i,:) = P;
  end

  % Deal with ends by padding ends with last computed value on each side.
  %fprintf('----------------------------------------------------------\n')
  for i = 1:Noffset
    % fprintf('Noffset = %d, i = %d, Noffset+1 = %d, Nx-Noffset-1 = %d\n', Noffset, i, Noffset+1, Nx-Noffset-1)    
    yf(i,:) = yf(Noffset+1,:);
    yf(Nx-i+1,:) = yf(Nx-Noffset-1,:);
  end
  
  % To compute the second order derivative of a polynomial of degree 2 fitting 7 points
  d2y = yf;
  d2y(:,2) = 2*P(1);
end
