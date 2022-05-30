%% Exercicio 4.2

% Parametros:
% x     - signal in the time domain
% win   - analysis window function
% hop   - hop size
% nfft  - number of FFT points
% fs    - sampling frequency, Hz

% Returns:
% STFT  - STFT-matrix
% f     - frequency vector, Hz
% t     - time vector, s

function [STFT, f, t] = stft(x, win, hop, nfft, fs)
% parse signal as a column vector
x = x(:);

% determination of the window length
wlen = length(win);

% stft matrix size estimation and preallocation
NUP = ceil((1+nfft)/2);             % number of unique fft points
L = 1+fix((length(x)-wlen)/hop);    % number of signal frames
STFT = zeros(NUP, L);               % initialize the stft matrix

% STFT (via time-localized FFT)
for l = 0:L-1
    xw = x(1+l*hop : wlen+l*hop).*win; % windowing
    X = fft(xw, nfft); % FFT
    STFT(:, 1+l) = X(1:NUP); % update of the stft matrix
end

% calculation of the time and frequency vectors
t = (wlen/2:hop:wlen/2+(L-1)*hop)/fs;
f = (0:NUP-1)*fs/nfft;
end