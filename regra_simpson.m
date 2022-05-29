function regra_simpson(fun,t1,tn,h)
    ft1=double(subs(fun,t1));
    ftn=double(subs(fun,tn));
    
    %para i par
    tvp=[t1+h:2*h:tn-h];
    sfp=sum(double(subs(fun,tvp));
    
    %para i impar
    tvi=[t1+2*h:2*h:tn-h];
    sfi=sum(double(subs(fun,tvi));
    
    int=(h/3)*(ft1+ftn+4*sfp+2*sfi);
    disp (int);
end



