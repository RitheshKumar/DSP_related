clear all;
close all;
clc;
fs=48000;
a1=[1,-1.69065929318241,0.73248077421585];
b1=[1.53512485958697,-2.69169618940638,1.19839281085285];
% f1=filter(b1,a1,w);
% [lol wol]=freqz(b1,a1,2048,fs);
% semilogx(wol,mag2db(abs(lol)));
a2=[1,-1.99004745483398,0.99007225036621];
b2=[1.0,-2.0,1.0];
% f2=filter(b2,a2,f1);
% figure
% [lol wol]=freqz(b2,a2,2048,fs);
% semilogx(wol,mag2db(abs(lol)));
noise=unifrnd(0,5,1,2048);
f1=filter(b1,a1,noise);
figure


n1=abs(fft(noise));
n1=n1(1:length(n1)/2);
n2=abs(fft(f1));
n2=n2(1:length(n2)/2);
diff=10*log10(n2)-10*log10(n1);
semilogx(diff);
f2=filter(b2,a2,f1);
n1=abs(fft(f2));
n1=n1(1:length(n1)/2);
diff=10*log10(n1)-10*log10(n2);
figure



semilogx(diff);


t = 0:0.001:2;            
[w fs] = audioread('/Users/coleshanholtz/Desktop/SCHOOL!/GA TECH/Hearing Cognition/Assignment 1/sinesweep.wav');

f1=filter(b1,a1,w);
n1=abs(fft(w));
n1=n1(1:length(n1)/2);
n2=abs(fft(f1));
n2=n2(1:length(n2)/2);
[lol wol]=freqz(b1,a1,length(n1),fs);
diff=10*log10(n2)-10*log10(n1);
figure


semilogx(wol,diff);
f2=filter(b2,a2,f1);
n1=abs(fft(f2));
n1=n1(1:length(n1)/2);
diff=10*log10(n1)-10*log10(n2);
figure

semilogx(wol,diff);
