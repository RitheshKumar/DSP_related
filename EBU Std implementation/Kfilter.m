function [ f2 ] = Kfilter( x, fs)

x1=x;
f2=[];

for j=1:2
   
x=x1(:,j);
    
a1=[1,-1.69065929318241,0.73248077421585];
b1=[1.53512485958697,-2.69169618940638,1.19839281085285];
f1=filter(b1,a1,x);
    
%     [lol wol]=freqz(b1,a1,2048,fs);
%     semilogx(wol,mag2db(abs(lol)));
%     figure
    
a2=[1,-1.99004745483398,0.99007225036621];
b2=[1.0,-2.0,1.0];
f2=filter(b2,a2,f1);
    
%     figure 
%     [loz woz]=freqz(b2,a2,2048,fs);
%     semilogx(woz,mag2db(abs(loz)));


end