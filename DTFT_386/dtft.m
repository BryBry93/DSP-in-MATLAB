function [X] = dtft(x,n,k)
% Computes discrete-time Fourier transform
% of a given seqeunce 'x', 
% M is usually  = 500, but here we will take the set w range as input
% and use the last most value as our M value
%%%%
% w = eval range [0,pi], or [-pi, pi]

% then wk = (pi/M)*k
% where k = 0,1,2 ... M
%%%%

%%%%%%%%%%%% modification

M = k(end)/2;   % take out '/2' in order plot 0:pi
                % otherwise its 
%%%%%%%%%%%%%

% w = (abs(w(end)-w(1))/500)*k % if you arent able to chnage input w
% consider range of w input
% w = (w(end)/500)*k; % or have the input w = 2*pi and use (w/500)*k

X = x*(exp(-1i*pi/M)).^(n'*k);

end