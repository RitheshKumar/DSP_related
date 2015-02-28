%does a negentropy based blind source separation 
clc;
clear all;
close all;
[s1,fs]=wavread('/Volumes/RITHESH/marseille conference/Matworks/piano2.wav');
s1=mean(s1,2);
s1=s1(1:263000);
s1=s1-mean(s1);
s1=s1/std(s1);
[s2,fs1]=wavread('/Volumes/RITHESH/marseille conference/Matworks/loop2.wav');
s2=mean(s2,2);
s2=s2(1:263000);
s2=s2-mean(s2);
s2=s2/std(s2);
[s3,fs2]=wavread('/Volumes/RITHESH/marseille conference/Matworks/pad.wav');
s3=mean(s3,2);
s3=s3(1:263000);
s3=s3-mean(s3);
s3=s3/std(s3);
[s4,fs2]=wavread('/Volumes/RITHESH/marseille conference/Matworks/flute2.wav');
s4=mean(s4,2);
s4=s4(1:263000);
s4=s4-mean(s4);
s4=s4/std(s4);
s=[s1,s2,s3,s4];
A=rand(4,2);
X=s*A; %mixture of all samples.
X1=mean(X,2);
[U,D,V]=svd(X,0);
z=U;
z=z./repmat(std(z,1),length(s1),1);
wego=0;
for i=1:100
    wp=randn(2,1);
    wp=wp./norm(wp,2);
    mogwai=z*wp;
    wp=mean(2*tanh(mogwai))-mean(1-(tanh(mogwai)).^2)*wp;
    wp=wp/norm(wp);
    wego(i,1:2)=wp';
end;
wego=max(wego);
out=z*wego'; %extracted sample
mono=audioplayer(out,fs);
play(mono);
SIR=(mean(X1.^2)/mean(out.^2))
10*log(SIR)
