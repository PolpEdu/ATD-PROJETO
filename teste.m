ficheiro = "HAPT Data Set/RawData/acc_exp21_user10.txt"; % - Ficheiro escolhido a acaso - %
data = importdata(ficheiro);
dft = abs(fftshift(fft(data)));
window = hamming(numel(data));
Fs = 50;
hopSize = length(window)/Fs;
nfft = numel(dft);


% - Chama-se a funcao para o calculo da STFT - %
figure()
spectrogram(dft,window,hopSize,[],Fs,'yaxis')
[STFT,f,t] = stft(data,window,hopSize,nfft,Fs);

C = sum(window)/length(window); % - Calculate the coherent amplification of the window - %
STFT = abs(STFT)/length(window)/C; % - Function of the length of the window and its coherent amplification - %

% - Correction of the DC & Nyquist component - %
if rem(nfft, 2)                     % - Odd nfft excludes Nyquist point - %
    STFT(2:end, :) = STFT(2:end, :).*2;
else                                % - Even nfft includes Nyquist point - %
    STFT(2:end-1, :) = STFT(2:end-1, :).*2;
end

STFT = 20*log10(STFT + 1e-6); % - Convert amplitude spectrum to dB (min = -120 dB) - %

% - Representacao Grafica - %

clims = [-120 20]; % - Set colour scale range (dB) - %
figure()
imagesc(t,f,STFT,clims)
colorbar
axis xy
xlabel('TIME (s)')
ylabel('FREQUENCY (Hz)')
title('Short-time Fourier Transform');