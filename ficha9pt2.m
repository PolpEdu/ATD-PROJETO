%% Ex2.1
clear all
close all
[imagem,map]=imread('Peppers (1).bmp');

%% Ex2.2
figure(1)
imshow(imagem,map);

%% Ex 2.3
X_imagem=fftshift(fft2(imagem));

N=length(X_imagem);
figure(2)
mesh(-N/2:N/2-1,-N/2:N/2-1, 20*log10(abs(X_imagem)));
axis([-N/2 N/2 -N/2 N/2])
view([-37.5 30])
%rotate3D;

disp('Indice da cor media no mapa de cores da imagem:')
C0=abs(X_imagem(N/2+1,N/2+1))/N/N
mean(mean(imagem))

figure(3)
imshow(C0*ones(size(imagem)),map);


