%% IIR Butterworth Filter design
%%
srate = 1024;
nyquist = srate/2;
freqR = [20 45]; %passband range

% 5th order butterworth filter
[fkernB,fkernA] = butter(5,freqR/nyquist); %filter coeffs, [numera.,denomin.]

% compute the power spectrum of filter coefficients
filtPow = abs(fft(fkernB)).^2;
hz = linspace(0,nyquist,floor(length(fkernB)/2)+1);

figure(1), clf
subplot(221), hold on
plot(fkernB*1e5,'ks-','linew',2,'markersize',10,'markerfacecolor','w')
plot(fkernA,'rs-','linew',2,'markersize',10,'markerfacecolor','w')
xlabel('Time points'), ylabel('Filter coeffs.')
title('Time-domain filter coefficients')
legend({'B';'A'})

subplot(222)
stem(hz,filtPow(1:length(hz)),'blue-','linew',2,'markersize',10,'markerfacecolor','w')
xlabel('Frequency (Hz)'), ylabel('Power')
title('Power spectrum of filter coeffs.')

%%
% generatre impulse response - all zeros and 1 in the middle
impRes = [zeros(1,500) 1 zeros(1,500)];
%Apply the Filter
Fimp = filter(fkernB,fkernA,impRes); % in the time domain
%compute the power spectrum
impPow = abs(fft(Fimp)).^2; % in the freq domain
hz = linspace(0,nyquist,floor(length(impRes)/2)+1);

subplot(222), cla, hold on
plot(impRes,'k','linew',2)
plot(Fimp,'r','linew',2)
set(gca,'xlim',[1 length(impRes)],'ylim',[-1 1]*.06)
legend({'Impulse';'Filtered'})
xlabel('Time points (a.u.)')
title('Filtering an impulse')

subplot(223), hold on
plot(hz,impPow(1:length(hz)),'rs-','linew',2,'markerfacecolor','w','markersize',10)
plot([0 freqR(1) freqR freqR(2) nyquist],[0 0 1 1 0 0],'k','linew',4)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation')
title('Frequency response of filter (Butterworth)')

subplot(224)
plot(hz,10*log10(impPow(1:length(hz))),'ks-','linew',2,'markerfacecolor','w','markersize',10)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation (log)')
title('Frequency response of filter (Butterworth)')
