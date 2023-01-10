function ret = dummyStorage(Mismatch,storage1)
if Mismatch < 0
    if abs(storage1) < abs(Mismatch)
        Mismatch = Mismatch - storage1;
        storage1 = 0;
    else
        storage1 = storage1 + Mismatch;
        Mismatch = 0;
    end
else
    storage1 = storage1 + Mismatch;
        Mismatch = 0;
end

    ret = Mismatch;
    assignin('base','storage1',storage1);
end


  

