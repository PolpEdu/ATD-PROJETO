%Ficha pratica 9 ex3
close all
clear all

%% Ex 1.1 Ler e escutar o sinal audio
[x,fs] = audioread('escala.wav');
sound(x,fs);
    
disp('Frequência de amostragem, f, [Hz]:');
fs
Ts = 1/fs;
disp('Periodo fundamental, N:');
N = numel(x)

X=fftshift((fft(x))); %DFT

%calcular o vetor de frequencias
if(mode(N,2)==0)
    %se o numero de pontos do sinal for par
    f=-fs/2:fs/N:fs/2-fs/N;
else
    %Se o numero de pontos do sinal for impar
    f=-fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
end

m_X=abs(X); %magnitude do sinal com ruído

t=linspace (0,(N-1)/fs,N);

figure()
subplot(211)
plot(t,x)
axis tight
xlabel('t [s]')
ylabel('Amplitude')
title('Sinal original')
subplot(212)
plot(f,m_X), hold on
title('|DFT| do sinal');
ylabel('Magnitude =|X|')
xlabel('f [Hz]')
axis tight

%determinar a frequência mais relevante em sucessivas janelas temporais com duração e sobreposição apropriadas (i.e., duração: 128ms e sobreposição: 64ms). Em cada janela, determinar a magnitude do espetro recorrendo a uma janela de Hamming (função hamming do Matlab) e selecionar a frequência fundamental como sendo a frequência com maior amplitude.

Tframe=0.128; %largura da janela de analise em S
toverlap=0.064; %sobreposição das janelas em s
Nframe=round(Tframe*fs); %numero de amostras na janela
Noverlap=round(toverlap*fs); %numero de amostras sobrepostas

h=hamming(Nframe); %janela de hamming
if(mode(N,2)==0)
    %se o numero de pontos do sinal for par
    f_frame=-fs/2:fs/Nframe:fs/2-fs/Nframe;
else
    %Se o numero de pontos do sinal for impar
    f_frame=-fs/2+fs/(2*Nframe):fs/Nframe:fs/2-fs/(2*Nframe);
end

freq_relev=[];
nframes=0; %para guardar
tframes=[];

%acho que temos de fazer um for destes no projeto
for ii=1:Nframe-Noverlap:N-Nframe
    %aplicar a janela ao sinal do tempo
    x_frame=x(ii:ii+Nframe-1).*h;
    
    %obter a magnitude do sinal
    m_X_frame=abs(fftshift(fft(x_frame)));
    
    %obter o maximo da magnitude do sina
    m_X_frame_max=max(m_X_frame);
    
    %encontrar os indices do maximo da magnitude do sinal
    ind=find(abs(m_X_frame-m_X_frame_max<0.001));
    
    %encontrar as frequencias correspondentes ao maximo de
    freq_relev=[freq_relev, f_frame(ind(2))];
    
    
    nframes=nframes+1;
    
    %calcular o vertor de tempo correpsondete a cada janela
    %corresponde ao valor do vector de tempos, t, em cada frame
    t_frame=t(ii:ii+Nframe-1);
    tframes=[tframes,t_frame(Nframe/2+1)];
end

freq_relev'

%indicar a resolução em frequencia em cada janela e representar
%graficamente ....

deltaf=fs/Nframe;
deltaf=Tframe-toverlap;

tframes
%outra maneira de calcular o tfranes tendo como valor  o tempo a janela
tframes2= 0:deltaf :deltaf*(nframes-1)
figure()
plot(tframes, freq_relev,'o')
xlabel('t [s]');
ylabel('f [hz]');
title('Sequencia de frequencias por janelas');


%% Ex3.3 Comparar o resultado com o espectrograma obtido com a função spectrogram.

figure()
spectrogram(x,Nframe,Noverlap,[],fs,'yaxis')

[s,f,t,p]=spectrogram(x,Nframe,Noverlap,[],fs);
%Encontrar os maximos em cada janela temporal

[I,A]=max(p);
freq_relev_spect=f(A)

%% Ex1.4 Determinar a sequência de notas musicais associadas a essas frequências do sinal.

f_notas=[262 277 294 311 330 349 370 392 415 440 466 494 523]
notas={'Dó  ';'Dó s';'Ré  ';'Ré s';'Mi  ';'Fá  ';'Fá s';'Sol ';'Sols';'Lá  ';'Lá s';'´Si  ';'Dó#2'};

ind_nj=[];

for k=1:length(freq_relev)
    
    %encontrar com as notas na gama de frequencias
    %[freq_relev(k)-5Hz, freq_relev(k)+5Hz]
    
    ind_freq=find(abs(f_notas-freq_relev(k))<5);
    
    
    ind_nj=[ind_nj;ind_freq];
    
end

disp('Sequencias de notas musicais em cada janela');
notas_xj=notas(ind_nj,:)


