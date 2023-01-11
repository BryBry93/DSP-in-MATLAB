function [y,n] = sigshift(x,m,k)

% Implements y(n) = x(n-k)
% where m = n0, k = the shifted comp.
% The shifted comp. of  'x(m-k)'
% -------------------------
% [y,n] = sigshift(x,m,k)

n=m+k; % so input m{position of x(n)} + k{shifted value}
y=x;
end

