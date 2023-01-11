%% EE 386 DTFT
%% TASK 1
% 1
% Using the matrix-vector multiplication approach discussed in section 2.1 of this lab, write a 
% Matlab function to compute the DTFT of a finite-duration sequence. 

%% Task 1a 
% over −𝜋 ≤ 𝜔 ≤ 𝜋. Plot DTFT magnitude and angle graphs.
%  𝑥(𝑛) = 𝑛(0.9)^𝑛 * [𝑢(𝑛) − 𝑢(𝑛 − 21)]
w = [0:1:500]*(2*pi)/500; % [0, pi] axis divided into 501 points.
a1 = 0.9.*ones(1,501).*exp(-1i*w);
X1a = (21*a1.^21 - 22*a1.^22 + a1 )./ (1-a1).^2;

magX1a = abs(X1a); angX1a = angle(X1a); realX1a = real(X1a); imagX1a = imag(X1a);

figure(1)
subplot(2,2,1); plot(w/(2*pi),magX1a); grid
title('Magnitude Part'); ylabel('Magnitude')
subplot(2,2,3); plot(w/(2*pi),angX1a); grid
xlabel('frequency in pi units'); title('Angle Part'); ylabel('Radians')
subplot(2,2,2); plot(w/(2*pi),realX1a); grid
title('Real Part'); ylabel('Real')
subplot(2,2,4); plot(w/(2*pi),imagX1a); grid
xlabel('frequency in pi units'); title('Imaginary Part'); ylabel('Imaginary')

%% Task 1b  
% over −𝜋 ≤ 𝜔 ≤ 𝜋. Plot DTFT magnitude and angle graphs of 
% 𝑥(𝑛) = {𝟒, 3, 2, 1, 1, 2, 3, 4}
n = 0:7;
w = [0:1:500]*(2*pi)/500;
x1b = [4 3 2 1 1 2 3 4];
X1b = dtft(x1b,n,w);

% might want to put all this junk in the function too
magX1b = abs(X1b); angX1b = angle(X1b); realX1b = real(X1b); imagX1b = imag(X1b);

figure(2)
subplot(2,2,1); plot(w/(2*pi),magX1b); grid
title('Magnitude Part'); ylabel('Magnitude')
subplot(2,2,3); plot(w/(2*pi),angX1b); grid
xlabel('frequency in pi units'); title('Angle Part'); ylabel('Radians')
subplot(2,2,2); plot(w/(2*pi),realX1b); grid
title('Real Part'); ylabel('Real')
subplot(2,2,4); plot(w/(2*pi),imagX1b); grid
xlabel('frequency in pi units'); title('Imaginary Part'); ylabel('Imaginary')
%% Task 2
%Let 𝑥1(𝑛) = { 𝟏, 2, 2, 1}. A new sequence 𝑥2(𝑛) is formed using:
%   x2(n) = {x1(n), 0<= n <=3} , {x1(n-4), 4<= n <=7}, {0, otherwise}
%% Part A done on paper
%% Task 2B
% Express X2(e^jw) in terms of X1(e^jw) without explicitly computing X1(e^jw)
x_1 = [1 2 2 1]; % seqeunce given
n1 = 0:3; % intervals 
n2 = 4:7;
w = [-250:1:250]*(2*pi)/500;

X1_A = dtft(x_1,n1,w); X1_B = dtft(x_1,n2,w);
X2 = X1_A + X1_B;

magX2 = abs(X2); angX2 = angle(X2); realX2 = real(X2); imagX2 = imag(X2);

figure(3)
subplot(2,2,1); plot(w/(pi),magX2); grid % < -- note I changed so it looks like 0 to 2pi
title('Magnitude Part of dtft(x_1,n1,w) + dtft(x_1,n2,w)'); ylabel('Magnitude')
subplot(2,2,2); plot(w/(pi),realX2); grid
title('Real Part'); ylabel('Real')
subplot(2,2,3); plot(w/(pi),angX2); grid
title('Magnitude Part'); ylabel('Magnitude')
xlabel('frequency in pi units'); title('Angle Part'); ylabel('Radians')
subplot(2,2,4); plot(w/(pi),imagX2); grid
xlabel('frequency in pi units'); title('Imaginary Part'); ylabel('Imaginary')

%%%% now plotting the result from part a

X3 = (1+exp(-1i*4*w)).*dtft(x_1,n1,w);
magX3 = abs(X3); angX3 = angle(X3); realX3 = real(X3); imagX3 = imag(X3);

figure(4)
subplot(2,2,1); plot(w/(pi),magX3); grid % < -- note I changed so it looks like 0 to 2pi
title('Magnitude Part of (1+exp(-1i*4*w)).*dtft(x_1,n1,w)'); ylabel('Magnitude')
subplot(2,2,2); plot(w/(pi),realX3); grid
title('Real Part'); ylabel('Real')
subplot(2,2,3); plot(w/(pi),angX3); grid
title('Magnitude Part'); ylabel('Magnitude')
xlabel('frequency in pi units'); title('Angle Part'); ylabel('Radians')
subplot(2,2,4); plot(w/(pi),imagX3); grid
xlabel('frequency in pi units'); title('Imaginary Part'); ylabel('Imaginary')
%% TASK 3
%  Let 𝑥(𝑛) be a random sequence uniformly distributed between [0, 1] over 
% 0 ≤ 𝑛 ≤ 10, and let 𝑦(𝑛) = 𝑥(𝑛 − 2). Using these two sequences, write a 
% Matlab script similar to Example 3 to verify the sample shift property.
% SamplShft: x(n-n0) => DTFT => exp(-jn0w)*X(exp(jw))
s = rng;
a = rand(0,11); 
rng(s);
x = rand(1,11); % contains exactly the same values as u1

n = 0:10;
k = 0:5000;
w = (pi/5000)*k; % <----- only needed for plotting

n0 = 2;

y = sigshift(x,n,n0);
Y1 = dtft(y,n,k);
% prove y1 = y2 .. where y2 = exp(-jn0w)*X(exp(jw))
Y2 = exp(-1i*(pi/5000)*n0)*dtft(x,n,k); 
% Y2 is DTFT => exp(-jn0w)*X(exp^jw) ...
% i.e. exp(-jn0w) * dtft of preshifted seq -> x

%%%%%%%%%%%%% Verification
error = max(abs(Y1-Y2)) % Difference 
%% TASK 4
% prove dtft(yn) = DTFT(-w0)
n = 0:100;
k = 0:500;
w0 = pi/4;
xn = cos(pi*n/2);
yn = exp(1i*w0*n).*xn;
%  dtft(yn)
Y1 = dtft(yn,n,k);
% vs X(exp(j*(w-w0)))
Y2 = xn*(exp(-1i*((pi/500)))).^((n-w0)'*k);
% or it might be : a -w0 next to the pi/500
% i.e. Y2 = xn*(exp(-1i*((pi/500)-w0))).^(n'*k);

% theory: the angle is the best comparison ... answers aren't very similar

error = max(abs(Y1-Y2)) % Difference

magy1 = abs(Y1); angy1 = angle(Y1); realy1 = real(Y1); imagy1 = imag(Y1);
magy2 = abs(Y2); angy2 = angle(Y2); realy2 = real(Y2); imagy2 = imag(Y2);
figure(5)
subplot(4,4,1); plot(k/500,magy1); grid
title('Magnitude Part of Y1'); ylabel('Magnitude')
subplot(4,4,3); plot(k/500,magy2); grid
title('Magnitude Part of Y2'); ylabel('Magnitude')

subplot(4,4,5); plot(k/500,angy1); grid
xlabel('frequency in pi units'); title('Angle Part of Y1'); ylabel('Radians')
subplot(4,4,7); plot(k/500,angy2); grid
xlabel('frequency in pi units'); title('Angle Part of Y2'); ylabel('Radians')

subplot(4,4,9); plot(k/500,realy1); grid
title('Real Part of Y1'); ylabel('Real')
subplot(4,4,11); plot(k/500,realy2); grid
title('Real Part of Y2'); ylabel('Real')

subplot(4,4,13); plot(k/500,imagy1); grid
xlabel('frequency of in pi units'); title('Imaginary Part of Y1'); ylabel('Imaginary')
subplot(4,4,15); plot(k/500,imagy2); grid
xlabel('frequency in pi units'); title('Imaginary Part of Y2'); ylabel('Imaginary')