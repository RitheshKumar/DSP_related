clear all;
close all; clc;
[X,Fs]= wavread('/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/audio/dry_mix/001_hit.wav');
% [X,Fs]= wavread('/Users/Rithesh/Documents/2nd sem/Alexander/drummer_3/audio/kick/090_phrase_shuffle-blues_complex_fast_sticks.wav');
% [X,Fs]= wavread('/Users/Rithesh/Documents/2nd sem/Alexander/drummer_3/drums2.wav');
X=mean(X,2);
Ws=2048;
OL=441;
stft = spectrogram(X, Ws, (Ws-OL), 2*Ws, Fs);
magi=abs(stft');
miss=zeros(length(magi(:,1))-1,length(magi(1,:)));
xlp=miss; xr=0;
ts=1/Fs; 
tm=0.01;
tav=1-exp(-2.2*ts*1000/tm);
for i=1:length(magi(1,:))
    miss(:,i)=diff(magi(:,i)); %calculating difference in magnitude of a frequency bin across time frames
%     xlp(i)=(1-tav)*xr+tav*magi(:,i);
%     xr=xlp(i);
end;
som=miss';
spflux=sum(som); %for all time, across one frequency
fluxnorm=(spflux-min(spflux))/(max(spflux)-min(spflux)); %normalised spectral flux
% plot(fluxnorm); mixum=fluxnorm-mean(fluxnorm); mixum(mixum<=0)=0; %HWR 
alp=0.95;
lpf=filter(1-alp,[1 -alp],mixum);
% lpf=filter(1-alp,[1 -alp],lpf);
% lpf=filter(1-alp,[1 -alp],lpf);
% lpf=filter(1-alp,[1 -alp],lpf);
% lpf=filter(1-alp,[1 -alp],lpf);
% lpf(lpf<=0.015)=0; %thresholding
% Lpf verification
% lpf1=lpf;
% alp=0.8;yp=0;
% for i=1:length(lpf1)
%     lpf1(i)=(1-alp)*mixum(i)+alp*yp;
%     yp=lpf1(i);
% end;
% figure
% plot(lpf1);



% figure
% plot(lpf);
ws=100;
lpf1=[lpf,zeros(1,ws-mod(length(lpf),ws))];
avg=max(reshape(lpf1,ws,[]));
for i=1:length(avg)
inx(i)=find(lpf==avg(i));
end;
onset=zeros(1,length(lpf));
onset(inx)=lpf(inx);
inset=onset;
inset(onset<=max(onset)/2)=0;
% inx=round(ws/2):ws:length(mav);
% mav(inx)=avg(1:end-1);
% win=100;
% for i=1:win:length(mixum)-win   %choose only the local maxima, and null the others: preserve time frame
% [m,n]=max(mixum(i:i+win-1));
% mixum(i:i+win-1)=0;
% mixum(n+i)=m;
% end;
figure
tindex=Ws/2:OL:(length(X)-Ws-1+OL); %calculating the time index, with time as the frame center.
plot(tindex/Fs,mixum);
figure
plot(tindex/Fs,inset);
xlabel('Time (s) --->');
ylabel('Normalised Magnitude -->');
title('Spectral Flux');

fileID=fopen('/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/groundtruth/1.txt');
C = textscan(fileID,'%f %s','Delimiter', '\n', 'CollectOutput', true);
trutimes=C{1};
instimes=find(inset);
differ=zeros(1,length(instimes));
for i=1:length(trutimes)
    d=abs(tindex(instimes)/Fs-trutimes(i));
    differ(i)=min(d);
end;
% d=length(instimes)-length(trutimes);
% cond=d>0;
% fp=cond.*d;
% fn=(~cond).*abs(d);
%creating a variable of groundtruth vs. time, based on stft window length
ghold=zeros(length(tindex),1);
found=ghold;
ghold(round(trutimes*Fs/OL))=1;
found(inset>0)=1;
fp=0;fn=0;
for i=1:length(ghold)-1
    if(ghold(i)~=found(i) && ghold(i)~=found(i+1))
        if found(i)==0
            fn=fn+1;
        else
            fp=fp+1;
        end;
    end;
end;
    
