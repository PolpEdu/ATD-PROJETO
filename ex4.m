x=-4:0.01:4;
y=-4:0.01:4;
[X,Y]=meshgrid(x,y);
f=sin(X.*Y)+cos(X);
mesh(X,Y,f);
pause;

x=sym('x');
y=sym('y');
f=sin(x.*y)+cos(x);
fmesh(x,y,f);
