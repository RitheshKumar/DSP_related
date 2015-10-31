clear all;
close all; clc;
[X,Fs]= wavread('/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/audio/dry_mix/040_hit.wav'); 
fileID=fopen('/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/groundtruth/40.txt'); 
% [X,Fs]= wavread('/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/audio/kick/090_phrase_shuffle-blues_complex_fast_sticks.wav');
% [X,Fs]= wavread('/Users/Rithesh/Documents/2nd sem/Alexander/drummer_3/drums2.wav'); 
X=mean(X,2); 
Ws=2048; OL=441; 
% Ws=4096; OL=441;
stft = spectrogram(X, Ws, (Ws-OL), 2*Ws, Fs); 
spectrep=abs(stft'); 


%SpectralFlux Evaluation 
differ=zeros(length(spectrep(:,1))-1,length(spectrep(1,:))); 
for i=1:length(spectrep(1,:)) 
    
    differ(:,i)=diff(spectrep(:,i));                         %calculating difference in magnitude 
                                                             %of a frequency bin across time frames 
end; 
differ(differ<=0)=0; spflux=sum(differ');                    %for one time, across all frequencies 
fluxnorm=(spflux-min(spflux))/(max(spflux)-min(spflux));     %normalised spectral flux 
fluxout=fluxnorm-mean(fluxnorm); 
fluxout(fluxout<=0)=0;                                       %HalfWaveRectification 


alp=0.87; 
lpf=filter(1-alp,[1 -alp],fluxout); 
% Find local maxima 
j=1;tru=0; 
for i=1:length(lpf)-1                                    %find indices of local maxima 
    if (lpf(i+1)-lpf(i))<=0 
        if tru==1 
            inx(j)=i; 
            j=j+1; 
            tru=0; 
        end; 
    elseif (lpf(i+1)-lpf(i))>0
        tru=1; 
    end; 
end; 

% Assign the values at found indices 
onset=zeros(1,length(lpf)); 
onset(inx)=lpf(inx); 

%threshold based onset eradication
onset(onset<(3*mean(onset)/4))=0;

%calculating the time index, with time as the frame center 
tindex=Ws/2:OL:(length(X)-Ws-1+OL); 

%Evaluation 
%the fastest one can play is 250 bpm, which is 4 beats per second: onset 
%differences must therefore be within 0.25 seconds.  
% fileID=fopen('/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/groundtruth/6.txt'); 
C = textscan(fileID,'%f %s','Delimiter', '\n', 'CollectOutput', true); 
trutimes=C{1}; 
instimes=find(onset); 
% instimes=find(fluxout);
mytimes=tindex(instimes)/Fs; 
tp=0;fp=0;fn=0; 
for i=1:length(mytimes) 
    if (find((trutimes>=(mytimes(i)-0.1) & (trutimes<=(mytimes(i)+0.1))))) 
        tp=tp+1; 
    else
        fp=fp+1; 
    end
end
jo=0; 
for i=1:length(trutimes) 
    if (find((mytimes>=(trutimes(i)-0.1)) & (mytimes<=(trutimes(i)+0.1)))) 
        jo=jo+1; 
    else
        fn=fn+1;
    end
end
rp=tp+fn; 
dp=tp+fp;
p=tp/dp;
r=tp/rp;
q=2*p*r/(p+r)
% q=(dp-(fn+fp))/(rp+(fn+fp))
% q1=q;
% save 'eval.mat' 'q1'; 
% load('eval.mat'); 
% q1=[q1, q] 
% save 'eval.mat' 'q1'; 


%Rubbish Dump 
% ws=50; 
% lpf1=[lpf,zeros(1,ws-mod(length(lpf),ws))]; 
% avg=max(reshape(lpf1,ws,[]));
% for i=1:length(avg) 
% if (avg(i)~=0)                         %finding the index of the peak, in a 
%   inx(i)=find(lpf==avg(i));            %given window of length ws 
% end; 
% end; 
% inx(inx==0)=[];
% inset=onset; 
% onset(onset<=max(onset)/2)=0; 
% xlp=differ; xr=0;
% ts=1/Fs; % tm=0.01; % tav=1-exp(-2.2*ts*1000/tm);
