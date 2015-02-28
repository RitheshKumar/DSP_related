%does a kurtosis based blind source separation 
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
s=[s1,s2,s3,s4]; %mixture of all four signals
A=rand(4,2);
X=s*A;
X1=mean(X,2);
[U,D,V]=svd(X,0);
z=U;
z=z./repmat(std(z,1),length(X),1);
w=0;kurt=0;
for i=1:100
    zinka=rand(2,1);
    y=z*zinka;
    yak=repmat(y.^4,1,2);
    g=mean(yak.*z);
    w=w+2*exp(-2)*g;
    w=w/norm(w);
    if w*w'==1
     break;
    end;
end;
out=z*w';
mono=audioplayer(out,fs);
play(mono);
SIR=(mean(X1.^2)/mean(out.^2))
10*log(SIR)