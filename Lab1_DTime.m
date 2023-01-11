%% EE386 - Lab 1 - Discrete Time Series
%%  Task 1.3
% 1.a) 
% Generate 𝑥1(𝑛) = 3𝛿(𝑛 + 2) + 2𝛿(𝑛) − 𝛿(𝑛 − 3) + 5𝛿(𝑛 − 7) − 5 ≤ 𝑛 ≤ 15
x1a = 3*impseq(-2,-5,15) + 2*impseq(0,-5,15) - impseq(3,-5,15) + 5*impseq(7,-5,15);
subplot(3,1,1)
stem(-5:15,x1a);
title('Sequence of 1a: x1(n)')

% 1.b)
% Generate 𝑥2(𝑛) = 10𝑢(𝑛) − 5𝑢(𝑛 − 5) − 10𝑢(𝑛 − 10) + 5𝑢(𝑛 − 15)] 0 ≤ 𝑛 ≤ 20
x1b = 10*stepseq(0,0,20) - 5*stepseq(5,0,20) - 10*stepseq(10,0,20) + 5*stepseq(15,0,20);
subplot(3,1,2)
stem(0:20,x1b);
title('Sequence of 1b: x2(n)')

% 1.c)
% Generate 𝑥3(𝑛) = 5[cos(0.49𝜋𝑛) + cos(0.51𝜋𝑛)] − 200 ≤ 𝑛 ≤ 200
n1c = [-200:200];
x1c = 5*(cos(0.49*pi*n1c)+cos(0.51*pi*n1c));
subplot(3,1,3)
stem(n1c,x1c);
title('Sequence of 1c: x3(n)')

%% Task 2a
%  Let 𝑥(𝑛) = {2, 4, −3, 𝟏, −5, 4, 7}. Generate and plot the samples 
% % (use the stem function) of the following sequences:

xn = [2 4 -3 1 -5 4 7];    n = [-3:3];

%  𝑥1(𝑛) = 2𝑥(𝑛 − 3) + 3𝑥(𝑛 + 4) − 𝑥(𝑛)

figure(2)

subplot(2,1,1)
stem(n,xn)
title('Original 𝑥(𝑛) = {2, 4, −3, 𝟏, −5, 4, 7}')

% y(n) = x(n-3) should be right shifted
[xn1,n1] = sigshift(xn,n,3); 
[xn2,n2] = sigshift(xn,n,-4);

%subplot(4,1,2), stem(n1,xn1)
%title('right shift by 3')
%subplot(4,1,3), stem(n2,xn2)
%title('left shift by 4')
%subplot(4,1,4), stem(n,xn)
%title('stay - will be multiplied by -1')

[a,na] = sigadd(2*xn1,n1,3*xn2,n2);
[A,nA] = sigadd(a,na,-xn,n);
subplot(2,1,2)
stem(nA,A)
title('result of shifted x1n')
%% Task 2b
%  Let 𝑥(𝑛) = {2, 4, −3, 𝟏, −5, 4, 7}. Generate and plot the samples 
% % (use the stem function) of the following sequences:
% xn = [2 4 -3 1 -5 4 7];          n = [-3:3];

%  𝑥2(𝑛) = 𝑥(𝑛 + 3)𝑥(𝑛 − 2) + 𝑥(1 − 𝑛)𝑥(𝑛 + 1)
xn2b = [0 0 0 0 2 4 -3 1 -5 4 7 0 0 0 0];
n2b = linspace(-7,7,15); 

figure(3)
subplot(2,1,1)
stem(n2b,xn2b)
title('Original 𝑥(𝑛) = {2, 4, −3, 𝟏, −5, 4, 7}')
[xn2b1,n2b1] = sigshift(xn2b,n2b,-3); %left shift 3
[xn2b2,n2b2] = sigshift(xn2b,n2b,2); %right shift 2

% Firstmost multp.
[xn2bA,n2bA] = sigmult(xn2b1,n2b1,xn2b2,n2b2); % A

%use sigfold
[xn2b3,n2b3] = sigshift(xn2b,n2b,1); %left shift 1
[xn2b3,n2b3] = sigfold(xn2b3,n2b3);

[xn2b4,n2b4] = sigshift(xn2b,n2b,1); %left shift 1

% Second multp.
[xn2bB,n2bB] = sigmult(xn2b3,n2b3,xn2b4,n2b4); % B

% Adding products A & B
[xn2bF,n2bF] = sigadd(xn2bA,n2bA,xn2bB,n2bB);

subplot(2,1,2)
stem(n2bF,xn2bF)
title('Plot of x2(n) = x(n+)x(n-2) + x(1-n)x(n+1)')
%% 3
% histogram(X,100)
%for kk = x  
 %   disp(kk)
%end

%    practice
%X = rand([1,7]);
%A = hist(X,100);

%bar(rand(10,5)) vs. bar(rand(10,5),'stacked')
%bar(A)

%% Task 3a
% 𝑥1(𝑛) is a random sequence whose samples are independent and uniformly 
% distributed over [0, 2] interval. Generate 100,000 samples.

x1n = 2*rand(1,100000);
A = hist(x1n,100); % histgrm of xin into 100 bins

% the histogram makes 'bins' determined by how common or relatively close a
% value is to another ... exp) the 2 smallest values are represented as a 
% vertical bar of height 2 and located at x=1 (since theyre the smallest
% out of the whole.. wheich means how the distribution is set (i.e. 1,1,
% 4, 9, 14, 13, 20) would group both 1's at x=1, the 4 around x=2, the 9
% around x = 5 .... all if we set 10 bins , b.c. then the x = 5 would
% represent the median values of the given set , (here 1 to 20)
% 
% the workspace shows a vector, where each elelmt is a number of how many
% are grouped together.... vector length is == set bin number

figure(4)
bar(A)
title('histogram of 3a')

%%  Task 3b
% Generate the following random sequences and obtain their histogram using 
% the hist function with 100 bins. Use the bar function to plot each histogram.
% 𝑥2(𝑛) = 𝑥1(𝑛) + 𝑥1(𝑛 − 1) where 𝑥1(𝑛) is the random sequence given in part (a).

x2n = sigshift(x1n,[1:length(x1n)],1);
B = hist(x2n,100);
figure(5)
bar(B)
title('histogram of 3b')

%% Task 4a
% Develop a Matlab function named dnsample that has the form:
% function [y,m] = dnsample(x,n,M)
% Downsample sequence x(n) by a factor M to obtain y(m)

x = [0 1 2 3 2 1 ]; %<--- I chose to start with 1, but i didnt have to
n = [0:5];

figure(6)
subplot(2,1,1)
stem(n,x)
title("Practice sequence: x = [0 1 2 3 2 1 ]")

[x2,n2] = dnsample(x,n,2);
subplot(2,1,2)
stem(n2,x2)
title('Downsample by of sequence x')

%% Task 4b
% Generate 𝑥(𝑛) = sin(0.125𝜋𝑛) − 50 ≤ 𝑛 ≤ 50. Then down-sampling 𝑥(𝑛) by a 
% factor of 4 to generate 𝑦(𝑛). Plot both 𝑥(𝑛) and y(𝑛) using subplot

n2 = [-50:50];
x4b = sin(0.125*pi*n2);

figure(7)
subplot(2,1,1)
stem(n2,x4b)
title('x(n) = sin(0.125*pi*n) -50<= n <= 50')

[x4b,n4b] = dnsample(x4b,n2,4);
subplot(2,1,2)
stem(n4b,x4b)
title('Problem 4b:  downsample x(n) by 4')