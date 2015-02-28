function [ ms, bs ] = MeanSquare( x )

x1=x;
ms=[];
bs=[];

for j=1:2
    x=x1(:,j);
bi=1;
count=1;
for i=1:4800:length(x)
    if((i+19200)>length(x))
        break;
    end;
    adsq=x(i:i+19199).^2;
    ms(count)= mean(adsq);
    count=count+1;
    bi=bi+1;
end;

%   bs(j,:)= ms;

end;



end

