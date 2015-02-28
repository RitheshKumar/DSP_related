clear all;
close all;
data=[];
for k=1:19
  load (sprintf('%d.dat',k))
  mix=eval(sprintf('X%d',k)); 
  for i=1:length(mix)
      rdecay(k,i)=mix(i,4);
      rspeed(k,i)=mix(i,3);
      rrnote(k,i)=mix(i,2);
      if (mix(i,5)==mix(i,8)) && (mix(i,6)==mix(i,9)) && (mix(i,7)==mix(i,10))
          magan(k,i)=1;
          decay(k,i)=mix(i,4);
          speed(k,i)=mix(i,3);
          rnote(k,i)=mix(i,2);
      else
          magan(k,i)=0;
      end;
  end;
          
end

%percentage correct, per person
% for k=1:19
%     stem(k,(sum(magan(k,:))/length(magan(1,:)))*100);
%     hold on;
% end;
dk=[5,10,45,100,200];
dkay=[2000,1000,250,100,50];
frange=5:5:60;
nrange=[220,880,3520];
%percentage correct, per decay/freq/rootnote per person
for k=1:19
    deakset(k,:)=histc(decay(k,:),dk);
    totdeakset(k,:)=histc(rdecay(k,:),dk);
    freakset(k,:)=histc(speed(k,:),frange);
    totfreakset(k,:)=histc(rspeed(k,:),frange);
    rootset(k,:)=histc(rnote(k,:),nrange); %no. of right answers for every rightnote
    totrootset(k,:)=histc(rrnote(k,:),nrange);
end;
fc=(sum(freakset)./sum(totfreakset))*100;
dc=(sum(deakset)./sum(totdeakset))*100;
rc=(sum(rootset)./sum(totrootset))*100;
stem(frange,fc);
title('Correctness per frequency');
xlabel('Frequency (Hz)');
ylabel('%correct');
figure;
stem(nrange,rc);
title('Correctness per rootnote');
xlabel('Rootnote (Hz)');
ylabel('%correct');
figure;
stem(dkay,dc);
title('Correctness per Decay Time');
xlabel('Time (ms)');
ylabel('%correct');
