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

%% Looping thru differnt butterworth IIR filter orders

orders = 3:6; %some errors on plotting subplot(223) when in 2:11 range - Conclusion: 11th order is far too high
fkernO = zeros(length(orders),1001);
HZ = linspace(0,srate,1001); % careful: srate not nyquist

figure(2), clf
title('Order Range: 2:11')
for out = 1:length(orders)
    % creating the filter kernel
    [FKB,FKA] = butter(orders(out),freqR/nyquist);
    n(out) = length(FKB);
    
    % filter the impulse response and take its power
    Fimp = filter(FKB,FKA,impRes); % filtered by the impulse response
    fkernO(out,:) = abs(fft(Fimp)).^2;
    
    % show in plot
    subplot(221), hold on
    plot((1:n(out))-n(out)/2,zscore(FKB)+out,'linew',2)
    
    subplot(222), hold on
    plot((1:n(out))-n(out)/2,zscore(FKA)+out,'linew',2) 
end
% plot labels
subplot(221)
xlabel('Time points')
title('Filter coefficients (B)')

subplot(222)
xlabel('Time points')
title('Filter coefficients (A)')


% plot the spectra
subplot(223), hold on
plot(HZ,fkernO,'linew',2) %(1:length(HZ)
plot([0 freqR(1) freqR freqR(2) nyquist],[0 0 1 1 0 0],'r','linew',4)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation')
title('Frequency response of filter (Butterworth)')

% in log space
subplot(224)
plot(HZ,10*log10(fkernO),'linew',2)
set(gca,'xlim',[0 100],'ylim',[-80 2])
xlabel('Frequency (Hz)'), ylabel('Attenuation (log)')
legend({'Order 2','Order 3','Order 4','Order 5','Order 6','Order 7','Order 8','Order 9','Order 10','Order 11'})
title('Frequency response of filter (Butterworth)')
