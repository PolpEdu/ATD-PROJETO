%% Exercicio 4, um exemplo
fich = "HAPT Data Set/RawData/acc_exp34_user17.txt"; % - Ficheiro escolhido a acaso - %
data = importdata(fich);
dft = abs(fftshift(fft(data)));
window = hamming(numel(data));
hopSize = length(window)/50;
nfft = numel(dft);
Fs = 50;

% - Chama-se a funcao para o calculo da STFT - %
figure
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

% Converter Amplitude do espetro para dB
STFT = 20*log10(STFT + 1e-6);

% - Representacao Grafica - %

clims = [-120 20]; % - Set colour scale range (dB) - %
figure
imagesc(t,f,STFT,clims)
colorbar
axis xy
xlabel('TIME (s)')
ylabel('FREQUENCY (Hz)')
title('Short-time Fourier Transform');