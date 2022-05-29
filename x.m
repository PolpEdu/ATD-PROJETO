function sig=x(n)
ix=union(find(n<-40),find(n>40));
sig=1.5*sin(0.025*pi*n);
sig(ix)=0;
end