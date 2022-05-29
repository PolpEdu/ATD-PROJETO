close all
PL=2;
b0=0.1*((mod(2,2)+1));
b1=0.4*mod(PL,2);
b2=0.4*mod(1+PL,2);
b3=0.3*(mod(PL,3)+1);
b4=-0.1*(mod(PL,4)+1);

n=[-50:50];
xn=x(n);
yn=b0*atrasa(xn,0)+ b1*atrasa(xn,1)+ b2*atrasa(xn,2)+ b3*atrasa(xn,3)+ b4*atrasa(xn,4);
figure;
plot(n,xn);
hold on;
plot(n,yn);
xlabel('n');
title('Resposta do siatema ao sinal sem ruido');
legend('x[n]','y[n]');

%Noise

r=(rand(1,numel(xn)).*0.4)-0.2; %gerar ruido
xnr=xn+r;
ynr=b0*atrasa(xnr,0)+ b1*atrasa(xnr,1)+ b2*atrasa(xnr,2)+ b3*atrasa(xnr,3)+ b4*atrasa(xnr,4);

figure;
plot(n,xn,n,xnr);
hold on;
plot(n,yn,n,ynr);
hold off;
xlabel('n');
title('Resposta do siatema ao sinal');
legend('x[n]','x[n] com ruido','y[n]','y[n] com ruido');

%Ex2
%y1[n]
figure;
subplot(4,1,1);
plot(n,xn,n,yn);
xlabel('n');
ylabel('y');
legend('x[n]','y1[n]');

%y2[n]
x2n=x(2.*n-4);
y2=0.6*x2n;
subplot(4,1,2);
plot(n,x2n,n,y2);
xlabel('n');
ylabel('y');
legend('x2[n]','y2[n]');

%y3[n]
y3=0.5*atrasa(xn,2).*atrasa(xn,3);
subplot(4,1,3);
plot(n,xn,n,y3);
xlabel('n');
ylabel('y3');
legend('x[n]','y3[n]');

%y4[n]

y4=(n-2).*atrasa(xn,3);
subplot(4,1,4);
plot(n,xn,n,y4);
xlabel('n');
ylabel('y4');
legend('x[n]','y4[n]');
%linearidade

a=3;
b=5;
%y1[n]
x1n=sin(0.1*pi*n);
x2n=cos(0.1*pi*n);

y1n=b0*atrasa(x1n,0)+ b1*atrasa(x1n,1)+ b2*atrasa(x1n,2)+ b3*atrasa(x1n,3)+ b4*atrasa(x1n,4);
y2n=b0*atrasa(x2n,0)+ b1*atrasa(x2n,1)+ b2*atrasa(x2n,2)+ b3*atrasa(x2n,3)+ b4*atrasa(x2n,4);

y1c=a*y1n+b*y2n;
xc =a*x1n +b*x2n;

y1xc=b0*atrasa(xc,0)+ b1*atrasa(xc,1)+ b2*atrasa(xc,2)+ b3*atrasa(xc,3)+ b4*atrasa(xc,4);

figure;
plot(n,y1c,n,y1xc,'k--');
title('Comparaçao para y1');
legend('Comb linear das ent.','Saida da comb.linear das ent');

%y2
x1_2n=sin(0.1*pi*(2*n-4));
x2_2n=cos(0.1*pi*(2*n-4));
y2n1=0.6*x1_2n;
y2n2=0.6*x2_2n;

y2c=a*y2n1+b*y2n2;
xc =a*x1_2n +b*x2_2n;


y2xc=0.6*xc;
figure;
plot(n,y2c,n,y2xc,'k--');
title('Comparaçao para y2');
legend('Comb linear das ent.','Saida da comb.linear das ent');

%y3
y3n1=0.5*atrasa(x1n,2).*atrasa(x1n,3);
y3n2=0.5*atrasa(x2n,2).*atrasa(x2n,3);

y3c=a*y3n1+b*y3n2;
xc =a*x1n +b*x2n;

y3xc=0.5*atrasa(xc,2).*atrasa(xc,3);

figure;
plot(n,y3c,n,y3xc,'k--');
title('Comparaçao para y3');
legend('Comb linear das ent.','Saida da comb.linear das ent');

%y4
y4n1=(n-2).*atrasa(x1n,3);
y4n2=(n-2).*atrasa(x2n,3);

y4c=a*y4n1+b*y4n2;
xc =a*x1n +b*x2n;

y4xc=(n-2).*atrasa(xc,3);

figure;
plot(n,y4c,n,y4xc,'k--');
title('Comparaçao para y3');
legend('Comb linear das ent.','Saida da comb.linear das ent');


%invariancia
%y1
xn=sin(0.1*pi*n);
k=4;
y1n=b0*atrasa(xn,0)+ b1*atrasa(xn,1)+ b2*atrasa(xn,2)+ b3*atrasa(xn,3)+ b4*atrasa(xn,4);

%calcular entrada atrasada
y1na=atrasa(y1n,4);

%calucalr saida com entrada atrasada
xn=atrasa(xn,4);
y1n=b0*atrasa(xn,0)+ b1*atrasa(xn,1)+ b2*atrasa(xn,2)+ b3*atrasa(xn,3)+ b4*atrasa(xn,4);

%para ser invariante y1na==y1n
figure;
plot(n,y1na,n,y1n,'k--');
title('Teste invariancia para y1');
legend('Saida atrasa.','Saida da entrada atrasada');

%y2
k=2;
x2n=sin(0.1*pi*(2*n-4));
y2n=0.6*x2n;

x2n=sin(0.1*pi*(2*n-4)-k);
%calcular entrada atrasada
y2na=atrasa(y2n,k);

figure;
plot(n,y2na,n,y2n,'k--');
title('Teste invariancia para y2');
legend('Saida atrasa.','Saida da entrada atrasada');

%y3
x3n=sin(0.1*pi*n);
y3n=0.5*atrasa(x3n,2).*atrasa(x3n,3);

y3na=atrasa(y3n,4);

x3n=atrasa(x3n,4);
y3n=0.5*atrasa(x3n,2).*atrasa(x3n,3);

figure;
plot(n,y3na,n,y3n,'k--');
title('Teste invariancia para y3');
legend('Saida atrasa.','Saida da entrada atrasada');

%y4
x4n=sin(0.1*pi*n);
y4n=(n-2).*atrasa(x4n,3);

y4na=atrasa(y4n,4);

x4n=atrasa(x4n,4);
y4n=(n-2).*atrasa(x4n,3);

figure;
plot(n,y4na,n,y4n,'k--');
title('Teste invariancia para y4');
legend('Saida atrasa.','Saida da entrada atrasada');

%resposta impulsional h1
xn=zeros(1,numel(n));
ix=find(n==0);
xn(ix)=1;

hn=b0*atrasa(xn,0)+ b1*atrasa(xn,1)+ b2*atrasa(xn,2)+ b3*atrasa(xn,3)+ b4*atrasa(xn,4);
figure;
stem(n,hn);
title('Resposta impuslional de y1[n]');
xlabel('n');

%resposta do sistema com base em h1
xn=x(n);
y1n=conv(xn,hn,'same');
figure;
stem(n,xn);
hold on;
stem(n,y1n);
title('y1[n]');
xlabel('n');
legend('xx[n]','y1[n]');




















