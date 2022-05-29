close all;
b3=0.3;
b4=-0.18;
a1=-1.5;
a2=0.56;
b=[0 0 0 b3 b4];
a=[1 a1 a2 0 0];
%pause;
%1.1

syms z
disp('Funçao de transferencia G(z):');
Gz=(b3*z^-3+b4*z^-4)/(1+a1*z^-1+a2*z^-2);
pretty(Gz);
%pause;

%1.2
disp('zeros:')
zGz=roots(b)
disp('polos:')
pGz=roots(a)

figure(1);
zplane(b,a);
%pause;

%1.3
if all(abs(pGz)<1)
    disp('O sistema é estavel');
else 
    disp('O sistema é instavel');
end

%1.4
disp('ganho do sistema');
ddcgain(b,a)
%pause 

%1.5
disp('Expressao de h[n]')
Hz=Gz;
hn=iztrans(Hz);
pretty(hn);


[r,p,k]=residuez([b3 b4],[1 a1 a2])
H2z_r= z^-3*(r(1)/(1-p(1)*z^-1))+z^-3*(r(2)/(1-p(2)*z^-1))
h2n_r=iztrans(H2z_r)
pretty(h2n_r)
nv=[0:50];
syms n
figure;
stem(nv,double(subs(hn,n,nv)))
hold on

stem(nv,double(subs(h2n_r,n,nv)),'+')
hold off
title('Respota a impulso do sistema via iztrans (o) e residuos (+)');

%1.6
n=0:50;
h=double(subs(hn));
h1=dimpulse(b,a,length(n));

figure;
stem(n,h,'o')
hold on
stem(n,h1,'+')
hold off
title('Resposta a impulso do sistema via iztrans (o) e dimpulse (+)');
xlabel('n');

%1.7
S2=sum(abs(h))
disp('O sistema é estavel porque sum(h[n]) é finita');
disp('O sistema é causal porque h[n]=0 para n<0')

%1.8
syms n
sympref('HeavisideAtOrigin',1);
Xz=ztrans(heaviside(n))
disp('Transformada de z de x[n]:')
pretty(Xz)

Yz=Hz*Xz;
yn=iztrans(Yz);
disp('Expressao de y[n]:')
pretty(yn)

%1.9
n=0:50;
y=double(subs(yn));
y1=dstep(b,a,length(n));

figure;
stairs(n,y,'-o')
hold on
stairs(n,y1,'-+')
hold off
title('Resposta a degrau do sistema via h[n] (o) e dstep(+)')
xlabel('n')

%1.10
disp('y[infinito]=')
yinf=double(limit((1-z^-1)*Yz,1))
yinf1=double(limit(yn,inf))
y(end)

%1.11
syms n
xn=3*(heaviside(n-2)-heaviside(n-10));
Xz=ztrans(xn);
disp('Transformada de z de x[n]')
pretty(Xz)

Yz=Hz*Xz;
yn=iztrans(Yz);

n=0:50;
y=double(subs(yn));
x=double(subs(xn));
y1=dlsim(b,a,x);

figure;
stairs(n,x,'-*');
hold on;
stairs(n,y,'-+');
stairs(n,y1,'-o');
hold off
title('Resposta a um pulso do sistema via h[n] (o) e dlsim(+)')
xlabel('n');
%pause

%1.12
syms o
Homega=subs(Hz,z,exp(j*o));
disp('Expressao de H(omega)')
pretty(Homega);

o=linspace(0,pi,100);
Ho_abs=double(subs(abs(Homega)));
Ho_ang=double(subs(angle(Homega)));

figure;
subplot(211)
plot(o/pi,20*log10(Ho_abs))
grid
ylabel('dB')
xlabel('Frequencia normalizada (x pi)');
title('Resposta em frequencia do sistema')
subplot(212)
plot(o/pi,180*unwrap(Ho_ang)/pi)
grid
ylabel('graus')
xlabel('Frequencia normalizada (x pi)');

%1.13
disp('Valor de H(0):')
%Ho_abs(1)
%Ho_ang(1)
M=abs(double(subs(Homega,0)));
A=angle(double(subs(Homega,0)));
%pause

%1.14
%usando Z
syms n
xn=2*sin(0.1*pi*n);
Xz=ztrans(xn);
Yz=Hz*Xz;

n=0:50;
x=double(subs(xn,n));
y=double(subs(yn));
yp=dlsim(b,a,x);

%Usando H(0)
disp('Valor de H(0.1*pi)');
Ho_abs1=double(subs(abs(Homega),0.1*pi))
Ho_abs1dB=20*log10(Ho_abs1)
Ho_ang1=double(subs(angle(Homega),0.1*pi))
Ho_ang1deg=180*Ho_ang1/pi

%pause
y2=Ho_abs1*2*sin(0.1*pi*n+Ho_ang1);

figure;
stairs(n,x,'.');
hold on
stairs(n,yp,'o')
stairs(n,y2,'*')
hold off
title('Resposta do sistema a uma sinusoide vai H[z] (+), dls')
xlabel('n')


