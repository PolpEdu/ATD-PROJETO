%% Exercicio 4, um exemplo
fich = "HAPT Data Set/RawData/acc_exp34_user17.txt"; % Random ficheiro
data = importdata(fich); % get the data
dft = abs(fftshift(fft(data))); % calculate dft
window = hamming(numel(data)); % Aplicar a janela de hamming (janela escolhida por nos)
Fs = 50;
clims = [-120 20]; % Defenir o intervalo de cores, dB são de -120 a 20
hopSize = length(window)/Fs;
nfft = numel(dft); % size of the dft


[STFT,f,t] = stft(data,window,hopSize,nfft,Fs); % calcular stft através da função

C = sum(window)/length(window); % Calculate the coherent amplification of the window 
STFT = abs(STFT)/length(window)/C; % Function of the length of the window and its coherent amplification 

% nfft é impar? Excluir Nyquist point, se for par incluir
if rem(nfft, 2)
    STFT(2:end, :) = STFT(2:end, :).*2;
else
    STFT(2:end-1, :) = STFT(2:end-1, :).*2;
end

% Converter Amplitude do espetro para dB
STFT = 20*log10(STFT + 1e-6);


figure
imagesc(t,f,STFT,clims) % apresentar a imagem
colorbar
axis xy
xlabel('TIME (s)')
ylabel('FREQUENCY (Hz)')
title('Short Time Fourier Transform (STFT)');