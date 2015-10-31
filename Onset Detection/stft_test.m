clear all;
close all;
l=2048*2;
simba=sin((1:l)/320);
plot(simba);
gimba=sin((1:l)/480);
figure
plot(gimba);
%mumba=downsample(simba,2);
mumba=sin(-80+(1:l)/320);
figure
plot(mumba);
figure
plot(abs(fft(simba(1:2048))));
figure
plot(abs(fft(gimba)));
figure
plot(abs(fft(mumba(1:2048))));

