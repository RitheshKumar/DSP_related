clear all;
close all; clc;
[X,Fs]= wavread('/Users/ritheshkumar/Documents/Alexander/TechLab/Onset Detection/dev2/sine_16.35.wav');
%sound(X,Fs);dev2__fort_minor-remember_the_name__snip_54_78__mix
flen=floor(length(X)/2750);
X=X(1:flen*2750);
%hamming window
n=1:2750;
w=0.54-0.46*cos(2*pi*n./2750);

%boing(n:n+2047,1:Fs)=2;
mama=w.*X(1:2750)';
plot(abs(fft(mama)))
