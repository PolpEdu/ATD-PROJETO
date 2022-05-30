%% Projeto ATD
close all
clear all
clc

%% Exercicio 1 
%Inicalizacao de variaveis

Expr={"21","22","23","24","25","26","27","28","29","30"}; % Array para os expr para os ficheiros
User = {"10","11","12","13","14","15"}; % Array para os users para os ficheiros
Fs = 50; % Frequência de amostragem dada no enunciado
Sensors = {"ACC_X","ACC_Y","ACC_Z"}; % Array para a s legendas dos graficos
activities = {"W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"};  % Array com todas as atitividades para conseguirmos dar label
all_labels = importdata("HAPT Data Set/RawData/labels.txt"); % Importa a data das labels

%% Exercicio 2 e 3
% Variaveis de controlo para conseguirmos desenhar as 10 figuras de uma vez
variavel_controlo_users = 0;
users = 1;

for k=1:numel(Expr)
    if (k ~=1 || numel(Expr)) % Se nao tivermos nem no ultimo nem no primeiro
        % ( que so ocorrem uma vez, tipo 21-10 e 30-15
       if (variavel_controlo_users==1) % Cada user tem duas exp, 22-11, 23-11
            variavel_controlo_users=0;
            % se ja tiver ocorrido 2 vezes ele começa de novo a contagem
            % e passa para o novo utilizador
            users = users + 1;
       else
            % se nao tiver ocorrido 2 vezes entao aumenta
            variavel_controlo_users = variavel_controlo_users +1;
       end
    else
        % no 1 e ultimo elemento do array dos exp o seu valor é sempre
        % igual a k, mas os nao
        exp = k;
       	if (numel(Expr))
            % se for o ultimo elemento do array dos exp damos-lhe o ultimo
            % elemento do array dos users
            users = 7;
        end
    end
    
    % carregamos os ficheiros todos 1 a 1
   ficheiro = sprintf("HAPT Data Set/RawData/acc_exp%s_user%s.txt",Expr{k},User{users})
   % ficheiro = "HAPT Data Set/RawData/acc_exp21_user10.txt";
    dacc = importdata(ficheiro);
    % damos import da data
    
    % labels para o ficheiro correspondente
    ix_labels = intersect(find(all_labels(:,1)==str2num(Expr{k})),find(all_labels(:,2)==str2num(User{users})));
     % ix_labels = intersect(find(all_labels(:,1)==str2num("21")),find(all_labels(:,2)==str2num("10")));
    %damos à data o valor do ficheiro
    data = dacc;
    % Criar vetor da data
    t=[0:size(data,1)-1]./Fs;

    %Get data size
    [n_pontos,n_plots] = size(data);
    
    %Desenha 10 figuras independentes
    figure;
    
     for i=1:n_plots % Desenha o grafico em si, 3 por figura
         subplot(n_plots,1,i);plot(t./60,data(:,i),"k--")
         axis([0 t(end)./60 min(data(:,i)) max(data(:,i))])
         xlabel("Tempo (mins)","fontsize",16,"fontweight","bold")
         ylabel(Sensors{i},"fontsize",16,"fontweight","bold");
         hold on
         for j=1:numel(ix_labels) % aqui vai dar as labels ao grafico
             plot(t(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5))./60,data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),i))
             if (mod(j,2)) == 1 % vai ver se deve ser em cima ou em baixo
                 ypos = min(data(:,i))-(0.2*min(data(:,i)));
             else
                 ypos = max(data(:,i))-(0.2*max(data(:,i)));
             end
             % aqui escreve efetivamente as labels
            text(t(all_labels(ix_labels(j),4))/60,ypos,activities{all_labels(ix_labels(j),3)},"VerticalAlignment","top","HorizontalAlignment","left");
             end
     end
     
end
%% Exercicio 4

%Calcular DFT


for i = 1:3
  % for j=ix_labels(1):ix_labels(numel(ix_labels)) % fazer por cada eixo os
  % usados não.
        x= squeeze(data(all_labels(ix_labels,4):all_labels(ix_labels,5),i));
        % w = hamming(length(x));
        y=fftshift((fft(x))); %DFT
         %y= fftshift(fft(x.*w));
        r =1:(all_labels(ix_labels,5)-(all_labels(ix_labels,4))+1);
        % suponho que isto seja os dfts do rodrigo ?
          figure()
         plot(r,y,"-")
        axis tight
   % end
end