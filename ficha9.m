clc 
clear all
close all

%% Ex 1.1 Ler e escutar o sinal audio
[x,fs] = audioread('escala.wav');
sound(x,fs);
%% Ex 1.2
disp('Frequência de amostragem, f, [Hz]:');
fs
Ts = 1/fs;
disp('Periodo fundamental, N:');
N = numel(x)

disp('Frequencia angular fundamental, Omega0, [rad]');
Omega0 = 2*pi/N


disp('Resolução em frequencia, [Hz]')
deltaf = fs/N

%% Ex1.3  Obter e representar o seu espetro (magnitude) de x[n], usando as funções fft, fftshift e abs.
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

%% Ex1.4 Identificar as frequências angulares (Omega em rad/s) e as frequências (f em Hz) mais relevantes do sinal (considerar as frequências cujas componentestêm magnitude superior a, por exemplo, 20% do valor máximo).
 max_x=max(m_X)
 min_mag=max_x -(0.2*max_x)
 plot(f,repmat(min_mag,N,1),'r')
 [pks,locs]=findpeaks(m_X,'MinPeakHeight',min_mag);  %util projeto
 
 f_relevant=f(locs);
 f_relevant =f_relevant(f_relevant>0)
 round(f_relevant)
 
 disp('Frequencias angulares')
 if(mod(N,2)==0)
     Omega=-Omega0*N/2:Omega0:Omega0*N/2-Omega0;
 else
     Omega=-Omega0*N/2+Omega0/2:Omega0:Omega0*N/2-Omega0/2;
 end
 
figure()
subplot(211)
plot(t,x)
axis tight
xlabel('t [s]')
ylabel('Amplitude')
title('Sinal original')
subplot(212)
plot(Omega,m_X), hold on
title('|DFT| do sinal');
ylabel('Magnitude =|X|')
xlabel('Omega [Hz]')
axis tight

Omega_relevant= Omega(locs);
Omega_relevant =Omega_relevant(Omega_relevant>0)



