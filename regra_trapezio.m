function regra_trapezio(exp,t1,tn,h)
tv=t1+h:h:tn-h;
ft1=double(subs(fun,t1));
ftn=double(subs(fun,tn));

integral=h*(((ft1+ftn)/2)+sum(double(subs(fun,tv))));
end 