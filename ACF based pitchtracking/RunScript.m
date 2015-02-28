
% Test Gammatone Filter bank

% [Saw,fs] = wavread('sawtooth_440.wav');
% [Square,fs] = wavread('square_440.wav');
% [Sine,fs] = wavread('sineSweep.wav');
% [Sax,fs] = wavread('sax.wav');


% 
% 
% GammaSaw=GTfilter(440,3520,8,Saw,fs);     %Gammatone filter function for 440 sawtooth wave, 8 bands
% GammaSquare=GTfilter(440,3520,8,Square,fs);     %Gammatone filter function for 440 square wave, 8 bands
% 
% GammaSweep=GTfilter(20,20000,10,Sine,fs); %10 band Gammatone filter on a 20-20kHz sine sweep 
% 
% 
% figure('Name','Gammatone Filter Bank Sawtooth Wave','NumberTitle','off')
% plot(GammaSaw)
% legend('show')
% 
% figure('Name','Gammatone Filter Bank Square Wave','NumberTitle','off')
% plot(GammaSquare)
% legend('show')
% 
% figure('Name','Gammatone Filter Bank Sine Sweep','NumberTitle','off')
% plot(GammaSweep)
% legend('show')


% figure('Name','Sax.wav Original','NumberTitle','off')
% plot(Sax);
% 
% figure('Name','Sax.wav Half Wave Rectified','NumberTitle','off')
% HWF = HalfWaveRect(Sax);
% plot(HWF);

% Test PitchTrack function

 PitchTrack('Samples/sax.wav')

% PitchTrack('svmono44.wav')
% PitchTrack('sineSweep.wav')

% PitchTrack('cathy_2.wav')

