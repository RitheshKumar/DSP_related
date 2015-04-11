%A simple Matlab script to visualize the autocorrelation of a signal.

clear all;
close all;
clc;

hi=figure;
set(hi,'Position', [200 200 1500 800])


t=-pi:2*pi/512:pi-2*pi/512;
x1=sin(50*t);
x2=sin(t);
x=x1.*x2;


% motions
hold on;
xlen=length(x);
k=1;
acorr=zeros(1,2*xlen+1);
for i=1:xlen
    toplot=[x((xlen-i+1):end) zeros(1,xlen-i)]; %left to right
    toplot1=[zeros(1,(xlen-i)) x(1:i)];         %right to left
    acorr(k)=sum(toplot.*toplot1);
    k=k+1;
    
    subplot(3,1,1)
    axis([1 xlen -1 1])
    h = plot(toplot);
    axis([1 xlen -1 1])
    
    subplot(3,1,2)
    axis([1 xlen -1 1])
    h1 = plot(toplot1);
    axis([1 xlen -1 1])
    
    subplot(3,1,3)
    axis([1 2*xlen+1 -130 130])
    h2=plot(acorr);
    axis([1 2*xlen+1 -130 130])
    
    pause(1/10000);
    delete(h);
    delete(h1);
    delete(h2);
end
for i=1:xlen
    toplot=[zeros(1,i) x(1:(xlen-i))];         %left to right
    toplot1=[x(i:end),zeros(1,i-1)];           %right to left
    acorr(k)=sum(toplot.*toplot1);
    k=k+1;
    
    subplot(3,1,1)
    axis([1 xlen -1 1])
    h = plot(toplot);
    axis([1 xlen -1 1])
    
    subplot(3,1,2)
    axis([1 xlen -1 1])
    h1 = plot(toplot1);
    axis([1 xlen -1 1])
    
    subplot(3,1,3)
    axis([1 2*xlen+1 -130 130])
    h2=plot(acorr);
    axis([1 2*xlen+1 -130 130])
    
    pause(1/10000);
    if i==xlen
        break;
    end
    delete(h);
    delete(h1);
    delete(h2);
end


