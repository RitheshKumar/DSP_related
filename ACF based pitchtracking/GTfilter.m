function matrix= GTfilter(minmf,maxmf,nbands,audi,samprate)

    band=log2(maxmf/minmf)/nbands;
    for i=1:nbands
     centre(i)=minmf*(2^(band*i));
    end
    matrix=gammatoneFast(audi,centre,samprate);
end
    
   
