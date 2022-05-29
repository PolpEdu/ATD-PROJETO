function [f,sf] = myfft(st,fs)
    sf = fft(st);
    sf = fftshift(sf)./(length(sf)-1);
    f = [-fs/2:fs/(length(sf)-1):fs/2];
end