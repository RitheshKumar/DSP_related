close all; clear all; clc;
t=0:2*pi/1024:(4*pi-2*pi/1024);
t1=linspace(0,2*pi-2*pi/1024,1024);
plot(sin(t1));
figure
plot(sin(1.5*t1))
s1=fft(sin(t1));
s2=fft(sin(1.5*t1));
figure
plot((mag2db(abs(s1))));
figure
plot((mag2db(abs(s2))));
