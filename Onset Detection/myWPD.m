%% onset detection using weighted phase deviation (WPD)
% objective: calculate novelty function using phase deviation information
% Paper : S. Dixon, 2006, onset detection revisited 
% Created by Chih-Wei Wu 2013.08.30 GTCMT, latest update: 2014.06 
% input: X is a m*n complex spectrogram matrix, m = # frequency bin, n = # frames
% output: nvt is a vector of novelty function

function [nvt] = myWPD(X)

P = angle(X);
[numFreq, numFrames] = size(P);

%initialization
nvt = zeros(1, numFrames);

%take second diff of phase
dP = diff(P, [], 2);
ddP = diff(dP, [], 2);

nvt = mean(abs(ddP.*X(:,1:size(ddP,2))), 1);
%nvt = mean(abs(ddP), 1);




% scaling
maxVal = max(max(nvt));
minVal = min(min(nvt));
nvt = (nvt - minVal)./(maxVal-minVal);