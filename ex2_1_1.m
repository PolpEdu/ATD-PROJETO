syms t;
x(t)=3 + cos(5*t +pi/2)+ 3*cos(6*t)+ cos(13*t-pi/2);
tv=[-T0/2:0.01:T0/2];
y=zeros(1,numel(tv));

for m=1:numel(c)
    y=y+C(m)*cos((m-1)*wo*tv*Teta(m));
end

plot(tv,y,'--','linewidth',3);
axis([-T0/2 T0/2 min(y) max(y));
grid on;
grid minor;
set(gca,'fontsize',20,'fontweigth','bold','linewidth',3)
xlabel('t');
ylabel('x1(t)');
title('x1(t)');

%analise da paridade
w=subs(x,'t',-t);

%representação grafica
T=0.1s;
syms n;
x1ns=subs(x,n*Ts);

t=linspace(-pi,pi,1000);
n=round(-pi/Ts):round(pi/Ts);

w=double(subs(x));
z=double(subs(x1ns));
plot(t,w,'-',n*Ts,z,'o');
xlabel('tempo[s]');
ylabel('Amplitude de x1(t) e x1[n]');



    