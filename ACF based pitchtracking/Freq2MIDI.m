function [ output ] = Freq2MIDI( x )
    

output   = 69 + 12*log2(x/440) ;

end

