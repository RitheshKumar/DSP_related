
clear all;
close all; clc;

fileID=fopen('list of groundtruth.txt'); 
D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
fileID=fopen('list of audiofiles.txt');
C = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
stringsgt=D{1};
stringsau=C{1};
gtstring='/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/groundtruth_renamed/';
austring='/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/audio/dry_mix/';

for ik=1:length(stringsgt)

fileID_i=fopen(char(strcat(gtstring,stringsgt(ik)))); 
[X,Fs]= audioread(char(strcat(austring,stringsau(ik)))); 

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


% alp=0.87; 
% lpf=filter(1-alp,[1 -alp],fluxout); 
lpf=fluxout;
% Find local maxima 
j=1;tru=0; 
for i=1:length(lpf)-1                                        %find indices of local maxima 
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
clear inx;
%threshold based onset eradication
onset(onset<(3*mean(onset)/4))=0;%eval2.mat eval4.mat

%calculating the time index, with time as the frame center 
tindex=Ws/2:OL:(length(X)-Ws-1+OL); 

%Evaluation 
%the fastest one can play is 250 bpm, which is 4 beats per second: onset 
%differences must therefore be within 0.25 seconds.  
G = textscan(fileID_i,'%f %s','Delimiter', '\n', 'CollectOutput', true); 
trutimes=G{1}; 
instimes=find(onset);%eval2.mat eval4.mat eval5.mat
% instimes=find(fluxout);%eval3.mat
mytimes=tindex(instimes)/Fs; 
tp=0;fp=0;fn=0; 
testru=trutimes;
testmy=mytimes;
for i=1:length(mytimes) 
    if (find((testru>=(mytimes(i)-0.05) & (testru<=(mytimes(i)+0.05))))) 
        tp=tp+1; 
        testru((testru>=(mytimes(i)-0.05) & (testru<=(mytimes(i)+0.05))))=[];
    else
        fp=fp+1; 
    end
end
jo=0; 
for i=1:length(trutimes) 
    if (find((testmy>=(trutimes(i)-0.05)) & (testmy<=(trutimes(i)+0.05)))) 
        jo=jo+1; 
        testmy((testmy>=(trutimes(i)-0.05)) & (testmy<=(trutimes(i)+0.05)))=[];
    else
        fn=fn+1;
    end
end
rp=tp+fn; 
dp=tp+fp;
p=tp/dp;
r=tp/rp;
% q=2*tp/(rp+dp);
% q=(dp-(fn+fp))/(rp+(fn+fp));
if(ik==1)
%     q4=q;
%     save 'eval4.mat' 'q4'; 
      p9=p;r9=r;
      save 'eval13.mat' 'p9' 'r9';
else
%     load('eval4.mat'); 
%     q4=[q4, q]; 
%     save 'eval4.mat' 'q4'; 
      load('eval13.mat');
      p9=[p9, p];
      r9=[r9, r];
      save 'eval13.mat' 'p9' 'r9';
end
disp('Iteration');disp(ik);
end
2*mean(p9)*mean(r9)/(mean(p9)+mean(r9))
%  2*mean(p5)*mean(r5)/(mean(p5)+mean(r5))
