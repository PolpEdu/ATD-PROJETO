clear all
clc
close all


%% Exercicio 1 
%variaveis
Fs = 50; % Frequ�ncia de amostragem dada no enunciado - passos por minuto
exp={"34","35","36","37","38","39","40","41"}; % Array para os exp para os ficheiros
User = {"17","18","19","20"}; % Array para os users para os ficheiros

atividades = {"W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"};  % Array com todas as atitividades para conseguirmos dar label
sensores = {"ACC_X","ACC_Y","ACC_Z"}; % Array para a s legendas dos graficos

% imports:
labels_info = importdata("HAPT Data Set/RawData/labels.txt");

%% Exercicio 2
par = 1; % variaveis para ajudar a selecionar a file correta.
users = 0;

% main loop
for i=1:numel(exp) 
    if (par==1) % cada user tem duas exp
        users = users + 1; % se ja tiver passado uma vez, aumenta o user.
        par=0;
    else
        % se nao continua o mesmo user
        par = 1;
    end

    
    % carregar ficheiro correspondente aos valores obtidos
    ficheiro = sprintf("HAPT Data Set/RawData/acc_exp%s_user%s.txt",exp{i},User{users})
    data_read = importdata(ficheiro);
    data = data_read;
    [n_pontos,n_plots] = size(data); % tamanho da data

    % labels para o ficheiro correspondente
    ix_labels = intersect(find(labels_info(:,1)==str2num(exp{i})),find(labels_info(:,2)==str2num(User{users})));
    
    % Criar vetor da data de acordo com a frequencia de amostragem obtida
    t=[0:size(data,1)-1]./Fs;
    
    % Desenha 8 figuras independentes
    figure;
    
    for i=1:n_plots % Desenha o grafico em si, 3 por figura
         subplot(n_plots,1,i);plot(t./60,data(:,i),"k--")

         axis([0 t(end)./60 min(data(:,i)) max(data(:,i))])
         xlabel("Tempo (mins)","fontsize",16,"fontweight","bold")
         ylabel(sensores{i},"fontsize",16,"fontweight","bold");
         hold on % salva o plot atual
         for j=1:numel(ix_labels)
             plot(t(labels_info(ix_labels(j),4):labels_info(ix_labels(j),5))./60,data(labels_info(ix_labels(j),4):labels_info(ix_labels(j),5),i))
             if (mod(j,2)) == 1 % vai ver se deve ser em cima ou em baixo
                 ypos = min(data(:,i))-(0.2*min(data(:,i)));
             else
                 ypos = max(data(:,i))-(0.2*max(data(:,i)));
             end
             % aqui escreve efetivamente as labels
            text(t(labels_info(ix_labels(j),4))/60,ypos,atividades{labels_info(ix_labels(j),3)},"VerticalAlignment","top","HorizontalAlignment","left");
        end
    end
end
%% Exercicio 4

%Calcular DFT


for i = 1:3
  % for j=ix_labels(1):ix_labels(numel(ix_labels)) % fazer por cada eixo os
  % usados n�o.
        x= squeeze(data(labels_info(ix_labels,4):labels_info(ix_labels,5),i));
        % w = hamming(length(x));
        y=fftshift((fft(x))); %DFT
         %y= fftshift(fft(x.*w));
        r =1:(labels_info(ix_labels,5)-(labels_info(ix_labels,4))+1);
        % suponho que isto seja os dfts do rodrigo ?
          figure()
         plot(r,y,"-")
        axis tight
   % end
end