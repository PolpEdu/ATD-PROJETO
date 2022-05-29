function rega_trapezio(exp,ti,ts)
    sum=0;
    for temp=ti+h:h:((ts-ti)/h)-1
        sum=sum+exp(temp);
    end
    integral=((exp(ti)+exp(ts))/2+sum)*h;
end