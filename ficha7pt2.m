%exercicio 2.1
w0=10*pi;
f0=w0/(2*pi);
fs=65;
ws=2*pi*fs;
Ts=1/fs;

syms t n
xtt=-1+3*sin(50*pi*t)+4*cos(20*pi*t+pi/4)*sin(40*pi*t)
xnn=subs(xtt,t,n*Ts)


%ex2.2
w0
Omega0=Ts*w0
T0=2*pi/w0
f0=1/T0;
N=T0/Ts

if(mod(N,2)==0)
    w=-ws/2:ws/N:ws/2-ws/N;
    Omega=-pi:2*pi/N:pi-2*pi/N;
else
    w=-ws/2+ws/N/2:ws/N:ws/2-ws/N/2;
    Omega=-pi+pi/N:2*pi/N:pi-pi/N;
end


%ex2.3
t=0:0.001:T0-0.001;
xt=double(subs(xtt));
n=0:N-1;
xn=double(subs(xnn));

figure(1)
plot(t,xt,n*Ts,xn,'o');
title('x(t) e x[n]')
xlabel('t[s]');

%2.4
x=fftshift(fft(xn))
x(abs(x)<0.001)==0;
abs_X=abs(x);
ang_X=angle(x);

figure(2);
subplot(211)
plot(w,abs_X,'o');
title('DFT-Transformada de Fourier Discreta');
ylabel('Magnitude, |x|')
xlabel('w [rad/s]')
subplot(212)

plot(w,unwrap(ang_X),'o');
ylabel('Frase <X [rad]');
xlabel('w [rad/s]');

figure(3);
subplot(211)
plot(Omega,abs_X,'o');
title('DFT-Transformada de Fourier Discreta');
ylabel('Magnitude, |x|')
xlabel('omega [rad/s]')
subplot(212)
plot(Omega,unwrap(ang_X),'o');
ylabel('Frase <X [rad]');
xlabel('Omega [rad/s]');


cm=x/N;
figure(4)
subplot(211)
plot(Omega/Omega0,abs(cm),'o');
title('Coeficientes da Serie de Fourier complexa');
ylabel('|cm|');
xlabel('m');
subplot(212)
plot(Omega/Omega0,unwrap(angle(cm)),'o');
ylabel(' <cm [rad]');
xlabel('m');

%ex2.6
ind=find(Omega>=0);
Cm=[abs(cm(ind(1))) 2*abs(cm(ind(2:end)))];
tetam=angle(cm(ind));

figure(5);
subplot(211)
plot(Omega(ind)/Omega0,Cm,'o');
title('Coeficientes da Serie de Fourier trigonometrica');
ylabel('Cm')
xlabel('m')
subplot(212)
plot(Omega(ind)/Omega0,tetam,'o');


%2.7
xtr=zeros(size(t));
m_max=Omega(ind(end))/Omega0;
for m=0:m_max
    xtr=xtr+Cm(m+1)*cos(m*wo*t+tetam(m+1));
end

figure(6)
plot(t,xt,t,xtr,'-.');
title('sinal x(t) e sinal reconstruido xr(t)');
xlabel('t [s]')







