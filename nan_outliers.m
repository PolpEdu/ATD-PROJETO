clear all;
load matlab.mat;
x=temp;

N=length(x);
t=(0:N-1);

plot(t,x,'-+')
%pause;

%ex1.2
haNaN=any(isnan(x));
colNaN=find(isnan(x));


%eliminar linha com Nan e reconstroi
x1r=x;
if(any(isnan(x)))
    ind=find(isnan(x));
    for k=1:length(ind)
        tt=t(ind(k)-4:ind(k)-1);
        xx=x1r(ind(k)-4:ind(k)-1);
        x1r(ind(k))=interp1(tt,xx,t(ind(k)),'pchip','extrap');
    end
end

%plot(t,x,'-+',t,x1r,'o');

%ex1.3
mu1=mean(x1r);
sigmal=std(x1r);

ix80=1;
ix89=find(years==1989)*12;
ix90=(find(years==1990)*12)-11;
ix99=(find(years==1999+1)*12)-12;

temp80=x1r(ix80:ix89);
temp90=(ix90:ix99);

corr=corrcoef(temp80,temp90);
disp(corr);
%pause;

%ex1.4
MeanMat1=repmat(mu1,N,1);
sigmalMat1=repmat(sigmal,N,1);
outliers=find(abs(x1r-mu1))>3*sigmal;
nout1=length(outliers);

x1ro=x1r;
if nout1
    for k=1:numel(outliers)
        if x1ro(outliers(k))>mu1
            x1ro(outliers(k))=mu1 +2.5*sigmal;
        else
            x1ro(outliers(k))=mu1 +2.5*sigmal;
        end
    end
end

%plot(t,x1,'++ ',t,x1ro,' --',t,x2ro,'o');
%pause;

%Parte 2 ex1.1
x1ro_to=detrend(x1ro,'constant'); %ordem 0
tr1_o=x1ro-x1ro_to;

x1ro_t1=detrend(x1ro,'linear'); %ordem 1
tr1_1=x1ro-x1ro_t1;
%plot(t,x1ro,'-+',t,tr1_o,'-*');
%pause;

%plot(t,x1ro_to,'-o');
%pause;

%plot(t,x1ro,'-+',t,tr1_1,'-*');
%pause;

%plot(t,x1ro_t1,'-o');
%pause;
%ex1.2

t=t';
p1=polyfit(t,x1ro,2);
tr1_2=polyval(p1,t);
x1ro_t2=x1ro-tr1_2;

%figure(4);
%subplot(211);
%plot(t,x1ro,'-+',t,tr1_2,'-*');
%subplot(212);
%plot(t,x1ro_t2,'-o');

%pause;
periodo=12;
x1ro_t2Mat=reshape(x1ro_t2,periodo,floor(numel(x1ro_t2))/periodo);
st1=repmat(mean(x1ro_t2Mat,2),floor(numel(x1ro_t2))/periodo,1);

x1ro_s=x1ro-st1;

%figure(5);
%subplot(211);
%plot(t,x1ro,'-+',t,x1ro_s,'-o');
%subplot(212);
%plot(t,st1,'-o');

pause;
%ficha 3 
%ex1.1
if(adftest(x1ro)==0)
    disp("Serie nao estacionaria")
else
    disp("serie estacionaria")
    
end

if(adftest(x1ro_t1)==0)
    disp("Serie sem tendencia de ordem 1 nao estacionaria")
else
    disp("serie sem tendencia de ordem 1 estacionaria")
    
end

%ex1.2
ix00=(find(years==2000)*12)-1;
%identificar tendencias
serie_treino=x1ro_t1(1:ix00);
serie_teste=x1ro_t1(ix00+1:end);

trend_treino=tr1_1(1:ix00);
trend_teste=tr1_1(ix00+1:end);

%criar objeto IDDATA
id_treino=iddata(serie_treino,[],1, 'TimeUnit','Months');

%ex1.3
figure;
parcorr(serie_treino,round(numel(serie_treino)/4));

opt1_AR=arOptions('Approach','ls');
na1_AR=12; %ordem do modelo
model1_AR=ar(id_treino,nal_AR,opt1_AR);
pcoef1_AR=polydate(model1_AR); %parametro do modelo AR

%ex1.4
y1_AR=serie_treino(end-na1_AR:end);
for k=(1:numel(serie_teste))+numel(y1_AR)
   y1_AR(k)=sum(-pcoef1_AR(2:end)'.*flip(y1_AR(k-nal_AR:k-1))); 
end
y1_AR=y1_AR+[trend_treino(end-nal_AR:end);trend_teste];
y1_ARf=forecast(model1_AR,serie_treino(end-nal_AR:end),numel(serie_teste));

%determinalao de vetores
tp=n-nal_AR:numel(y1_AR)-(nal_AR+1);
to=[1:numel(serie_teste)];

figure;
plot(to,serie_teste+trend_teste,'-+',tp,y1_AR,'-o',to,y1_ARf);

E1_AR=sum(((serie_teste+trend_teste)-(y1_ARf+trend_teste)).^2);


rangeAR=[1:3:199];
ErroAR=zeros(1,numel(rangeAR));
k=1;
while(k<=numel(rangeAR))
    nal_AR=rangeAR(k);
    model1_AR=ar(id_treino,nal_AR,opt1_AT);
    pcoef1_AR=polydata(model1_AR);
    y1_ARf=forecast(model1_AR,serie_treino(end-nal_AR:end),numel(serie_teste));
    ErroAR(k)=sum(((serie_teste+trend_teste)-(y1_ARf+trend_teste)).^2);
    k=k+1;
end


figure;
autocorr(serie_treino,round(numel(serie_treino)/4));
opt1_ARMAX=armaxOptions('Seacrh Method','auto');
nal_ARMA=12 ;
ncl_ARMA=5;
model_ARMA=armax(id_treino,[nal_ARMA ncl_ARMA],opt1_ARMAX);
[pal_ARMA,pbl_ARMA,pcl_ARMA]=polydata(model1_ARMA);

%ex1.6
npoints2pred=numel(serie_teste)+nal_ARMA +1;
y1_ARMA=serie_treino(end-nal_ARMA:end);
e= randn(numel(serie_teste)+numel(y1_ARMA),1);
for k=numel(y1_ARMA):npoints2pred
    y1_ARMA(k)=sum(-pal_ARMA(2:end)'.*flip(y1_ARMA(k-nal_ARMA:k-1)))+sum(pcl_ARMA'.*flip(e(k-ncl_ARMA:k)));
end
y1_ARMA=y1_ARMA+[trend_treino(end-nal_ARMA:end);trend_teste];
y1_ARMAf=forecast(model1_ARMA,serie_treimo(end-nal_ARMA:end),numel(Serie_teste));

tp=-nal_ARMA:numel(y1_ARMA)-(nal_ARMA+1);

figure;
plot(to,serie_teste+trend_teste,'-+',tp,y1_ARMA,'-o',to,y1_ARMAf);

E1_ARMA=sum(((serie_teste+trend_teste)-(y1_ARMAf+trend_teste)).^2);

opt1_ARMAX=armaxOptions('SearchMethod','auto');
rangeAR=[1:2:50];
rangeMA=[1:2:30];
ErroARMA=zeros(numel(rangeAR),numel(rangeMA));
n=1
while(n<=numel(rangeAR))
m=1;
while(m<=numel(rangeAR))
    nal_ARMA=rangeAR(n);
    ncl_ARMA=rangema(M);
    model1_ARMA=ar(id_treino,[nal_ARMA ncl_ARMA],opt1_AT);
    [pal_ARMA,pbl_ARMA,pcl_ARMA]=polydata(model1_ARMA);
    npoints2pred=numel(serie_teste)+nal_ARMA +1;
    
    y1_ARMAf=forecast(model1_ARMA,serie_treino(end-nal_ARMA:end),numel(serie_teste));
    ErroAR(n,m)=sum(((serie_teste+trend_teste)-(y1_ARMAf+trend_teste)).^2);
    m=m+1;
end
n=n+1;
end

[N,M]=meshgrid(rangeAR',rangeMA');
figure;
mesh(N',M',log(ErroARMA));

%ex1.7
p1_ARIMA=12;
D1_ARIMA=1;
q1_ARIMA=5;

Md1=arima(p1_ARIMA,D1_ARIMA,q1_ARIMA);


%ex1.8
serie_treino=x1ro(1:ix00);
serie_teste=x1ro(ix00+1:end);
EstMd=estimate(Md1,serie_treino);

y1_ARIMA=simulate(EstMd,numel(serie_teste),'yo',seri_treino(end-(p1_ARIMA+D1_ARIMA)+1:end));

figure;
plot(to,serie_teste,'-+',to,y1_ARIMA,'-o');


E1_aRIMA=sum(((serie_teste)-(y1_ARIMA)).^2);























