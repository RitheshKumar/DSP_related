function [ pitch ] = PitchTrack( filename )


blockSize = 4096;
hopSize = 2048;
a=0;
 

[X,fs] = wavread(filename);

 gtone=GTfilter(100,3000,20,X,fs); %Gammatone filter function to provide a 20 band filterbank. 
 
 recti=HalfWaveRect(gtone); % Halfwave rectifcation to emulate neural transduction
 
 fLengthLpInS    = 0.001;
 iLengthLp       = ceil(fLengthLpInS*fs);
 b               = ones(iLengthLp,1)/iLengthLp;
 for i=1:length(recti(1,:))  %Moving Average filter for low pass auditory emulation
     mAvg(:,i) = filtfilt(b,1,recti(:,i));
 end
 
 for j=1:length(mAvg(1,:)) %ACF per block for every band
  count=1; 
  for i=1:blockSize:(length(mAvg(:,1))-blockSize)
    aCorr(j,count,:)=  ACF(mAvg(i:i+ (blockSize-1) ,j));
    count=count+1;
  end;
 end;
 
 

 for i=1:length(aCorr(1,:,1))
   sumcorr(i,:)=(sum(aCorr(:,i,:)));  %sum ACF results across bands per block
   sumtemp=sumcorr(i,:);
   [x,y]=max(sumtemp);
   for j=y+22:(y+3000)              %limit the frequency to below 2000 Hz
       if sumtemp(j)<sumtemp(j+1)
           [maxi,a]=max(sumcorr(i,j:y+3000));
           a=a+j;
           break;
       end
   end
   freq(i)=fs/(a-y);
 end;
 
 pitch=Freq2MIDI(freq);   %convert fundamental to MIDI note and plot
 plot(pitch);
 

end


