clear all

x=load('datasetfp7.dat');
Ts=4*10^-3; %Ts=4ms
ws=2*pi/Ts;
N=length(x);
Omega0=2*pi/N;
T0=N*Ts;
w0=2*pi/T0;

t=[0:N-1].*Ts;
plot(t,x);

xlabel('Tempo')

m_max=80;
[Cm,tetam]=SerieFourier(t,x,T0,m_max);


figure(1);
plot(t,x);

title('x[n] dado pelo dataset');
xlabel('t[s]');


m=0:m_max;
figure(2);
subplot(211);
plot(m,Cm,'o');
ylabel('Cm');
xlabel('m')
subplot(212);
plot(m,tetam,'o');


%exercicio 1.1.2
mt=[0 10 40 80];

figure(3);
plot(t,x);
title('Reconstruçao de x[n]');
xlabel('t[s]');
hold on

for k=1:length(mt)
    xa=zeros(size(t));
    for m=0:mt(k)
        xa=xa+Cm(m+1)*cos(m*2*pi/T0*t+tetam(m+1));
    end
    plot(t,xa,'-g');
    
end
hold off

%exercicio 1.1.3

cmneg=Cm(end:-1:2)/2.*exp(-j*tetam(end:-1:2));
c0=Cm(1)*cos(tetam(1));
cmpos=Cm(2:end)/2.*exp(j*tetam(2:end));
cm=[cmneg; c0; cmpos];

m=-m_max:m_max;
figure(4);
subplot(211);
plot(m,abs(cm),'bo');
title('Coeficientes da Serie de Fourier complexa')
ylabel('abs(cm)')
xlabel('m')
subplot(212);
plot(m,unwrap(angle(cm)),'bo');
ylabel('angle(cm)')
xlabel('m')


%exercicio 1.1.4
x=fftshift((fft(x)));
x(abs(x)<0.001)=0; %anular valores residuais

if(mod(N,2)==0)
    w=-ws/2:ws/N:ws/2-ws/N;
    Omega=-pi:2*pi/N:pi-2*pi/N;
else
    w=-ws/2+ws/N/2:ws/N:ws/2-ws/N/2;
    Omega=-pi+pi/N:2*pi/N:pi-pi/N;
end

figure(5);
subplot(211);
plot(m,abs(cm),'bo',w/w0,abs(x)/N,'r*');
title('Comparação dos coeficientes cm com a DFT/T0')
ylabel('|cm| e |DFT|/N')
xlabel('m')
subplot(212);
plot(m,unwrap(angle(cm)),'bo',w/w0,unwrap(angle(x)),'r*');
ylabel('<cm e <DFT [rad]')
xlabel('m')

figure(6);
subplot(211);
plot(m*w0,abs(cm),'bo',w,abs(x)/N,'r*');
title('Comparação dos coeficientes cm com a DFT/T0')
ylabel('|cm| e |DFT|/N')
xlabel('w [rad/s]')
subplot(212);
plot(m*w0,unwrap(angle(cm)),'bo',w,unwrap(angle(x)),'r*');
ylabel('<cm e <DFT [rad]')
xlabel('w [rad/s]')

figure(7);
subplot(211);
plot(m*Omega0,abs(cm),'bo',Omega,abs(x)/N,'r*');
title('Comparação dos coeficientes cm com a DFT/T0')
ylabel('|cm| e |DFT|/T0')
xlabel('Omega [rad]')
subplot(212);
plot(m*Omega0,unwrap(angle(cm)),'bo',Omega,unwrap(angle(x)),'r*');
ylabel('<cm e <DFT [rad]')
xlabel('Omega [rad]')

%1.2
m=0:m_max;
ind=find(Cm>0.1);
disp('Componentes de frequencia do sinal x[n], m:');
disp(m(ind))
disp('Frequencias do sinal x[n], Omega [rad]:');
omega_xn=m(ind)*2*pi/N;
disp(omega_xn)
disp('frequencias do sinal x(t), w[rad/s]');
w_xt=m(ind)*2*pi/T0;
disp(w_xt)
disp('Frequencia do sinal x(t, f[Hz]');
disp(w_xt/2/pi)














