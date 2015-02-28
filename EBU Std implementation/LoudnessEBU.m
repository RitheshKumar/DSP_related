function [ lufs, lu ] = LoudnessEBU( x )

[w, fs]= audioread(x);

rt=audioplayer(w,fs);


w1=w;

if( fs~=48000)
error = MException('VerifyOutput:OutOfBounds', ...
             'Incorrect Sampling Rate');
         throw(error);
         
         
if (length(x(1,:))>2)
    err = MException('VerifyOutput:OutOfBounds', ...
             'Too many audio channels');
         throw(err);
         
    x=mean(x,length(x(1,:)));
end;         
end;

for j=1:2
    w=w1(:,j);
bi=1;count=1;
    for i=1:4800:length(w)
        if((i+19200)>length(w))
            break;
        end;
    
        adsq=w(i:i+19199).^2;
        ms(count)=mean(adsq);
        
        count=count+1;
     bi=bi+1;
end;

  bs(j,:)=ms

end;

% plot(10*log10(sum(bs)));



for j=1:2
    w=w1(:,j);
a1=[1,-1.69065929318241,0.73248077421585];
b1=[1.53512485958697,-2.69169618940638,1.19839281085285];
    f1=filter(b1,a1,w);


a2=[1,-1.99004745483398,0.99007225036621];
b2=[1.0,-2.0,1.0];
    f2=filter(b2,a2,f1);


bi=1;
add=0;
count=1;

        for i=1:4800:length(f2)
                    if((i+19200)>length(f2))
                          break;
                      end;
            
            ms(bi)=(rms(f2(i:i+19199)))^2;

            lk(bi)=-0.691+10*log10(ms(bi));
%             hist(lk);
            
            if(lk(bi)>-70.0)
                bur(count)=ms(bi);
                count=count+1;
            end;
            
            
    bi=bi+1;
end;
fre(j,:)=f2;
bor(j,:)=mean(bur);
end;


lkg=-0.691+10*log10(sum(bor));
rth=lkg-10;


for j=1:2
    
for i=1:4800:length(f2)
    if((i+19200)>length(f2))
        break;
    end;
    ms(bi)=(rms(fre(j,i:i+19199)))^2;

    lk(bi)=-0.691+10*log10(ms(bi));
    if(lk(bi)>rth)
       bur(count)=ms(bi);
       count=count+1;
    end;
    bi=bi+1;
end;
bor(j,:)=mean(bur);
end;

lufs=-0.691+10*log10(sum(bor));
lu = lufs + 23;



end

