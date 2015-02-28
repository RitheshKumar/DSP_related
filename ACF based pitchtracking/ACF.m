function matrix=ACF(input)

auco=xcorr(input,input);

matrix=(auco-min(auco))/(max(auco)-min(auco)); %normalising the autocorr
end