A=[1,2,3,4;5,6,7,8];
B=randi([2,9],size(A,1),size(A,2))
save ('abfile.mat', 'A', 'B');
clear all;
load('abfile.mat');
pause;
A(:,2)=[];
B(:,3)=[];
pause;
CA=[10;30];
CB=[20;50];
A=[CA A];
B=[B CB];
CP=[A(1,:);B(end,:)];
C=A+B;
C=B-A;
C=A*B';
C=A.*B;
C=A/B;
C=A./B;
pause;

%exercicio 2
t=-10:0.01:10;
f=sin(2*pi*t)+sin(pi*t);
plot(t,f);
pause;
%exercicio 3
t=sym('t');
f=sin(2*pi*t)+sin(pi*t);
t=-10:0.01:10;

f1=double(subs(f));
figure;
plot(t,f1);


