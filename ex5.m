t=0:10;
y =[0 0.7 2.4 3.1 4.2 4.8 5.7 5.9 6.2 6.4 6.3]
z=polyfit(t,y,2);
ye=polyval(z,t);

plot(t,ye,'o',t,ye,'-')