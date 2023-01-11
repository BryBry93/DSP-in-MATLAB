function [y,m] = dnsample(x,n,M)
% Downsample sequence x(n) by a factor M to obtain y(m)

% to pre-allocate
Mn = zeros([1,length(n)]);
y = zeros([1,length(x)]);

% create new range of n values
for i = 1:length(n)
    Mn(i) = M*n(i); % Mn =[0 2 4 6 8 10]
end

% then get the Mn elements of the sample
% i.e. x(Mn(1)) , x(Mn(1)), x(Mn(2))...
% i.e. x(0)   , x(2),    x(4) ...
%j = 1;
j = 1;
for k = 1:length(Mn) % for k in Mn
    if Mn(j) == 0  % k wont ever hit zero anymore since 1:100
        y(j) = x(j);
        j = j + 1;
    elseif abs(Mn(j)) >= n(end) 
        y(j) = 0;
        j = j + 1;
        %continue    
    elseif Mn(j) < 0
        y(j) = x(abs(n(1)-Mn(j))+1);
        j = j + 1;
    elseif n(1) >= 0  % incase the input n is a array starting at 0
        y(j) = x(Mn(j)+1);% of array of only positives, I only need Mn(j)+1
        j = j + 1;
    elseif Mn(j) > 0  % if the input n is an array from neg to positive values
        y(j) = x(n(end)+Mn(j)+1);
        j = j + 1;
    end
end
y;
m = n;
end

