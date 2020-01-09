%% Time-Frequency Analysis to Filter a Recording
% Filter using a zero-phase shift filter with reflection
% alternatively use the filtfilt() function

% Not using Welch's method: 
% which takes FT of a window, over successive windows, then averege each 
% of the resulting power spectrums



% The following is for a Mono (single channel) recording



%%                              Part 1

%% Instead use Time-Frequency Analysis
[Y,fs] = audioread('SB2.mp3'); 
% Y = is audio size dat by 2 (2 channels) USUALLY 2     
% fs = the sampling rate

% created time vector since none was given
N = length(Y);
timevec = (0:N-1)/fs;

% play file
soundsc(Y,fs)
%% plot sound file
figure(1), clf
subplot(211)
plot(timevec,Y)
title('Time Domain')
xlabel('Time (sec)')
set(gca,'ytick',[],'xlim',timevec([1 end]))
% in 2 channel, splot with offset
% plot(timevex,bsxfun(@plus,bc,[.2 0]))  .2 offset , 0/normal for the other


% plot the power spectrum
hz = linspace(0,fs/2,floor(N/2)+1);
Ypow = abs(fft(detrend(Y(:,1)))/N).^2;

subplot(212)
plot(hz,Ypow(1:length(hz)),'linew',2)
title('Power spectrum of Recoding  Frequncy Domain')
xlabel('Frequency (Hz)')
set(gca,'xlim',[0 180]) 

%% __________ Freq Analysis __________
% Essentialy, theres a Major power peak at ~36Hz
% but we can see a few other peak, with relative mathing amplt.
% yet all less that the ~36hx peak


% conclusion: this freq domain tells us NOTHING about the recording
%% Clac and plot the spectrogram for time-freq analysis
%Essentially combines the last 2 plots, time & freq together

[powspect,frex,time] = spectrogram( detrend(Y(:,1)) , hann(500) , 100 , [] , fs );
% spectrogram(X,WINDOW,NFFT,fs) -
% divides X (the signal) into segments same length as window
% NFFT spec the numb of freq points used to calc FT
% fs specs sampling rate
% hann, returns 10000-point symmetric hann window as a column vec


% plotting 
figure(2), clf
imagesc(time,frex,abs(powspect).^2) %frames image axii: imagesc(x,y,funct)
axis xy
set(gca,'clim',[0 1]*2,'ylim',frex([1 dsearchn(frex,8000)]),'xlim',time([1 end]))
xlabel('Time (sec.)'), ylabel('Frequency (Hz)')
colormap hot

% ____________ Time-Frequency Analysis ____________
% Play the sound file while looking at the Spectrogram 
% --- COLOR is POWER !!! ---- Energy over the time and freq
%i.e. color intensisty corrsp to the height of peaks in freq domain
%%                              Part 2

%% Selecting the frequency ranges to narrowband filter

frange{1} = [100 700]; % Matches the initial Freq Power Spec plot
frange{2} = [100 1000];

% draw boundary lines on the plot
colorz = 'wm';
hold on
for fi=1:length(frange)
    plot(get(gca,'xlim'),[1 1]*frange{fi}(1),[colorz(fi) '--' ]) %first index
    plot(get(gca,'xlim'),[1 1]*frange{fi}(2),[colorz(fi) '--' ]) %second index
end
% Boundry lines wont work with more than two frange{}
%% Inspect the time and frequency response of the filter kernel
% over the chosen freq ranges

nyquist = fs/2;
Order = round(25*fs/frange{1}(1)); % Looks Great @ order 21

FK1 = fir1(Order,frange{1}/nyquist);


FKPow = abs(fft(FK1)).^2;
Htz = linspace(0,nyquist,floor(length(FK1)/2)+1);
FKPow = FKPow(1:length(Htz));
% plotting the filter kernel for range 1
figure(3), hold on
subplot(131)
plot(FK1)
%set(gca,'xlim',[2200 2800])
xlabel('Time Points')
title('Filter Kernel for Range(1)')
axis square
%plotting the freq response for range 1
subplot(132), hold on
plot(Htz,FKPow,'ks-','linew',2,'markerfacecolor','w')
plot([0 frange{1}(1) frange{1} frange{1}(2) nyquist],[0 0 1 1 0 0],'ro-','linew',2,'markerfacecolor','w')
% make the plot look nicer
set(gca,'xlim',[0 frange{1}(2)*1.2])%,'ylim',[-.05 1.05])
xlabel('Frequency (Hz)'), ylabel('Filter gain')
legend({'Actual';'Ideal'})
title('Frequency response of filter (fir1) for Range(1)')
axis square
%plotting the freq response in db for range 1
subplot(133), hold on
plot(Htz,10*log10(FKPow),'ks-','linew',2,'markersize',10,'markerfacecolor','w')
plot([1 1]*frange{1}(1),get(gca,'ylim'),'k:')
set(gca,'xlim',[0 frange{1}(2)*1.2],'ylim',[-80 2])
xlabel('Frequency (Hz)'), ylabel('Filter gain (dB)')
title('Frequency response of filter (fir1) for Range(1)')
axis square


%Range 2


FK2 = fir1(Order,frange{2}/nyquist);
FKPow2 = abs(fft(FK2)).^2;
Htz2 = linspace(0,nyquist,floor(length(FK2)/2)+1);
FKPow2 = FKPow2(1:length(Htz2));
% plotting the filter kernel for range 2
figure(4), hold on
subplot(131)
plot(FK2)
%set(gca,'xlim',[2000 3000])
xlabel('Time Points')
title('Filter Kernel for Range(2)')
axis square
%plotting the freq response for range 1
subplot(132), hold on
plot(Htz2,FKPow2,'ks-','linew',2,'markerfacecolor','w')
plot([0 frange{2}(1) frange{2} frange{2}(2) nyquist],[0 0 1 1 0 0],'ro-','linew',2,'markerfacecolor','w')
% make the plot look nicer
set(gca,'xlim',[0 frange{2}(2)*1.2])%,'ylim',[-.05 1.05])
xlabel('Frequency (Hz)'), ylabel('Filter gain')
legend({'Actual';'Ideal'})
title('Frequency response of filter for Range(2)')
axis square
%plotting the freq response in db for range 2
subplot(133), hold on
plot(Htz2,10*log10(FKPow2),'ks-','linew',2,'markersize',10,'markerfacecolor','w')
plot([1 1]*frange{2}(1),get(gca,'ylim'),'k:')
set(gca,'xlim',[0 frange{2}(2)*1.2],'ylim',[-80 2])
xlabel('Frequency (Hz)'), ylabel('Filter gain (dB)')
title('Frequency response of filter for Range(2)')
axis square

%% Apply the fir1  to filter the signal
filtSig = cell(1,1);


% loops :   large loop, loops over the two freq ranges set from inspection
%           The inner loop, loops over the 2 channels
for filteri = 1:length(frange)
    
    % filter kernel
    order = round(25*fs/frange{1}(1)); %order = 10
    filtKern = fir1(order,frange{filteri}/(fs/2)); % rebuiling a new kernel for the 1st and second freq ranges
    % fs/2 is the nyquist
    % fir1 uses zero transition zones (calls firls) .. applied window to 
    % time dom filter kernel in order to smooth out the edges (essn creates
    % transistion zones
    
    data1chan = Y;
       
    % zero phase shift filter with reflection
    sigR = [data1chan(end:-1:1); data1chan; data1chan(end:-1:1)]; % reflect
    fsig = filter(filtKern,1,sigR);                 % forward filter
    fsig = filter(filtKern,1,fsig(end:-1:1));       % reverse filter
    fsig = fsig(end:-1:1);                          % reverse again for 0phase
    fsig = fsig(N+1:end-N);                         % chop off reflected parts
       
    filtSig{filteri} = fsig;    
end

%% Play the filtered recording
% ORIGINAL soundsc(Y,fs)
soundsc(filtSig{2},fs)
%soundsc(filtsig{},fs)  {1} then {2}, to play each isolated range
figure(5)
subplot(211)
plot(time,filtSig{2}(1:length(time)))
title('NarrowBand Filtered Recording')
xlabel('Time (sec)')
set(gca,'ytick',[],'xlim',timevec([1 end]))

Fpow = abs(fft(detrend(filtSig{2}(:,1)))/N).^2;

subplot(212)
plot(hz,Fpow(1:length(hz)),'linew',2)
title('Power spectrum of Filtered Recoding in Frequncy Domain')
xlabel('Frequency (Hz)')
set(gca,'xlim',[190 800])

[Fspect,FqX,time2] = spectrogram( detrend(filtSig{1}) , hann(1000) , 100 , [] , fs );

% plotting 
figure(6), clf
imagesc(time2,FqX,abs(Fspect).^2) %frames image axii: imagesc(x,y,funct)
axis xy
set(gca,'clim',[0 1]*2,'ylim',FqX([1 dsearchn(FqX,1000)]),'xlim',time2([1 end]))
xlabel('Time (sec.)'), ylabel('Frequency (Hz)')
colormap hot


%% NEXT PART
% WOrk on seeing/plotting the kernel ----- DONE!
% and see the effects   ----- DONE! 
% ---------------      Order @ 25 was chosen. freq response was best there
% then see affects of varying kernels
%% NEXT NEXT Part
% try sing filtfilt() fucntion instead of zero phase - 
% whats the diffeence in theory and in the output ???