clear all
close all
clc

%% Exercicio 1 
% Inicializar variaveis

Fs = 50; % Frequencia de amostragem dada no enunciado - passos por minuto
exp= {"34","35","36","37","38","39","40","41"}; % Array para os exp para os ficheiros
User = {"17","18","19","20"}; % Array para os users para os ficheiros

% Array com todas as atitividades para conseguirmos dar label
atividades = {"W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"};  
% Array para as legendas dos graficos
sensores = {"ACC_X","ACC_Y","ACC_Z"}; 

% imports:
labels_info = importdata("HAPT Data Set/RawData/labels.txt");

w_x = {{},{},{},{},{},{},{},{}};
w_y = {{},{},{},{},{},{},{},{}};
w_z = {{},{},{},{},{},{},{},{}};
 
w_up_x = {{},{},{},{},{},{},{},{}};
w_up_y = {{},{},{},{},{},{},{},{}};
w_up_z = {{},{},{},{},{},{},{},{}};
 
w_down_x = {{},{},{},{},{},{},{},{}};
w_down_y = {{},{},{},{},{},{},{},{}};
w_down_z = {{},{},{},{},{},{},{},{}};
 
sit_x = {{},{},{},{},{},{},{},{}};
sit_y = {{},{},{},{},{},{},{},{}};
sit_z = {{},{},{},{},{},{},{},{}};
 
stand_x = {{},{},{},{},{},{},{},{}};
stand_y = {{},{},{},{},{},{},{},{}};
stand_z = {{},{},{},{},{},{},{},{}};
 
lay_x = {{},{},{},{},{},{},{},{}};
lay_y = {{},{},{},{},{},{},{},{}};
lay_z = {{},{},{},{},{},{},{},{}};
 
stand2sit_x = {{},{},{},{},{},{},{},{}};
stand2sit_y = {{},{},{},{},{},{},{},{}};
stand2sit_z = {{},{},{},{},{},{},{},{}};
 
sit2stand_x = {{},{},{},{},{},{},{},{}};
sit2stand_y = {{},{},{},{},{},{},{},{}};
sit2stand_z = {{},{},{},{},{},{},{},{}};
 
sit2lay_x = {{},{},{},{},{},{},{},{}};
sit2lay_y = {{},{},{},{},{},{},{},{}};
sit2lay_z = {{},{},{},{},{},{},{},{}};
 
lay2sit_x = {{},{},{},{},{},{},{},{}};
lay2sit_y = {{},{},{},{},{},{},{},{}};
lay2sit_z = {{},{},{},{},{},{},{},{}};
 
stand2lay_x = {{},{},{},{},{},{},{},{}};
stand2lay_y = {{},{},{},{},{},{},{},{}};
stand2lay_z = {{},{},{},{},{},{},{},{}};
 
lay2stand_x = {{},{},{},{},{},{},{},{}};
lay2stand_y = {{},{},{},{},{},{},{},{}};
lay2stand_z = {{},{},{},{},{},{},{},{}};



%% Exercicio 2
par = 1; % variaveis para ajudar a selecionar a file correta.
users = 0;

for k=1:numel(exp) 
    if (par==1) % cada user tem duas exp
        users = users + 1; % se ja tiver passado uma vez, aumenta o user.
        par=0;
    else
        % se nao continua o mesmo user
        par = 1;
    end

    % carregar ficheiro correspondente aos valores obtidos
    ficheiro = sprintf("HAPT Data Set/RawData/acc_exp%s_user%s.txt",exp{k},User{users})
    data_read = importdata(ficheiro);
    data = data_read;
    [n_pontos,n_plots] = size(data); % tamanho da data

    % labels para o ficheiro correspondente
    info_labels = intersect(find(labels_info(:,1)== str2num(exp{k})),find(labels_info(:,2)== str2num(User{users})));
    
    % Criar vetor da data de acordo com a frequencia de amostragem obtida
    t=[0:size(data,1)-1]./Fs;
    
    % Desenha 8 figuras independentes
    figure;
    
    for i=1:n_plots % Desenha o grafico em si, 3 por figura
         subplot(n_plots,1,i);plot(t./60,data(:,i),"k--")
         axis([0 t(end)./60 min(data(:,i)) max(data(:,i))])
         xlabel("Time(mins)","fontsize",16,"fontweight","bold")
         ylabel(sensores{i},"fontsize",16,"fontweight","bold");
         hold on % salva o plot atual
         for j=1:numel(info_labels)
             plot(t(labels_info(info_labels(j),4):labels_info(info_labels(j),5))./60,data(labels_info(info_labels(j),4):labels_info(info_labels(j),5),i))
             if (mod(j,2)) == 1 % vai ver se deve ser em cima ou em baixo
                 ypos = min(data(:,i))-(0.2*min(data(:,i)));
             else
                 ypos = max(data(:,i))-(0.2*max(data(:,i)));
             end
             % escrever as labels
            text(t(labels_info(info_labels(j),4))/60,ypos,atividades{labels_info(info_labels(j),3)},"VerticalAlignment","top","HorizontalAlignment","left");
        end
    end


%% Exercicio 3
% guardar para variaveis os diferentes estados
    for i=1:size(info_labels,1)
        switch labels_info((info_labels(i,1)),3)
            case 1
                temp = w_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                w_x{k} = temp;
 
                temp = w_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                w_y{k} = temp;
 
                temp = w_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                w_z{k} = temp;
 
            case 2
                temp = w_up_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                w_up_x{k} = temp;
 
                temp = w_up_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                w_up_y{k} = temp;
 
                temp = w_up_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                w_up_z{k} = temp;
 
            case 3
                temp = w_down_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                w_down_x{k} = temp;
 
                temp = w_down_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                w_down_y{k} = temp;
 
                temp = w_down_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                w_down_z{k} = temp;
 
            case 4
                temp = sit_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                sit_x{k} = temp;
 
                temp = sit_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                sit_y{k} = temp;
 
                temp = sit_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                sit_z{k} = temp;
 
            case 5
                temp = stand_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                stand_x{k} = temp;
 
                temp = stand_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                stand_y{k} = temp;
 
                temp = stand_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                stand_z{k} = temp;
 
            case 6
                temp = lay_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                lay_x{k} = temp;
 
                temp = lay_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                lay_y{k} = temp;
 
                temp = lay_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                lay_z{k} = temp;
 
            case 7
                temp = stand2sit_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                stand2sit_x{k} = temp;
 
                temp = stand2sit_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                stand2sit_y{k} = temp;
 
                temp = stand2sit_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                stand2sit_z{k} = temp;
 
            case 8
                temp = sit2stand_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                sit2stand_x{k} = temp;
 
                temp = sit2stand_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                sit2stand_y{k} = temp;
 
                temp = sit2stand_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                sit2stand_z{k} = temp;
 
            case 9
                temp = sit2lay_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                sit2lay_x{k} = temp;
 
                temp = sit2lay_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                sit2lay_y{k} = temp;
 
                temp = sit2lay_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                sit2lay_z{k} = temp;
 
            case 10
                temp = lay2sit_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                lay2sit_x{k} = temp;
 
                temp = lay2sit_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                lay2sit_y{k} = temp;
 
                temp = lay2sit_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                lay2sit_z{k} = temp;
 
            case 11
                temp = stand2lay_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                stand2lay_x{k} = temp;
 
                temp = stand2lay_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                stand2lay_y{k} = temp;
 
                temp = stand2lay_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                stand2lay_z{k} = temp;
 
            case 12  
                temp = lay2stand_x{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),1);
                lay2stand_x{k} = temp;
 
                temp = lay2stand_y{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),2);
                lay2stand_y{k} = temp;
 
                temp = lay2stand_z{k};
                temp{size(temp,2)+1} = data(labels_info(info_labels(i,1),4):labels_info(info_labels(i,1),5),3);
                lay2stand_z{k} = temp;
            otherwise
        end
    end
end

%% Exercicio 3
% Arrays com os passos por segundo
steps_w = [];
steps_wup = [];
steps_wdown = [];

%Passos Totais (Uma parcela é um ficheiro)
total_steps_w = zeros(numel(exp),1);
total_steps_wup = zeros(numel(exp),1);
total_steps_wdown = zeros(numel(exp),1);

%{
Sensibilidade:
SE = VP * 100 Verdadeiros positivos sobre verdadeiros positivos + falsos negativos
VP + FN
-----
Especificidade:
Esp = VN*100
VN +FP
%}

% foi usada a janela "blackman"
for n=1:numel(exp) % Para as atividades dinamicas:
    %WALKING
    for i=1:1:size(w_z{n},2)
        black_win = blackman(numel(w_z{n}{i}));
        dft = fftshift(fft(detrend(w_z{n}{i}).*black_win));
        m = abs(dft);
        
        f = (0:length(dft)-1)*100/length(dft);
        
        [pks_m, pks_f] = findpeaks(m);
        Ts=1/pks_f(1);
        
        steps_w = [steps_w; 60/Ts];
        total_steps_w(n) = total_steps_w(n) + (size(w_z{n}{i},1)/Fs)/Ts;
    end
    
    %WALKING UPSTAIRS
    for i=1:1:size(w_up_z{n},2)
        black_win = blackman(numel(w_up_z{n}{i}));
        dft = fftshift(fft(detrend(w_up_z{n}{i}).*black_win));
        m = abs(dft);
        f = (0:length(dft)-1)*100/length(dft);
        
        [pks_m, pks_f] = findpeaks(m);
        
        Ts=1/pks_f(1);
        
        steps_wup = [steps_wup; 60/Ts];
        total_steps_wup(n) = total_steps_wup(n) + (size(w_up_z{n}{i},1)/Fs)/Ts;
    end
    
    %WALKING DOWNSTAIRS
    for i=1:1:size(w_down_z{n},2)
        black_win = blackman(numel(w_down_z{n}{i}));
        dft = fftshift(fft(detrend(w_down_z{n}{i}).*black_win));
        m = abs(dft);
        f = (0:length(dft)-1)*100/length(dft);
        
        [pks_m, pks_f] = findpeaks(m);
        
        Ts=1/pks_f(1);
        
        steps_wdown = [steps_wdown; 60/Ts];
        total_steps_wdown(n) = total_steps_wdown(n) + (size(w_down_z{n}{i},1)/Fs)/Ts;
    end
end

%  Media steps por minuto
media_steps_w_sec = mean(steps_w)
media_steps_wup_sec = mean(steps_wup)
media_steps_wdown_sec = mean(steps_wdown)

% Desvio 
dp_steps_w_sec = std(steps_w)
dp_steps_wup_sec = std(steps_wup)
dp_steps_wdown_sec = std(steps_wdown)

figure();
hold on

%%% 3.5 - Retirar comentários para visualizar a data no scatter!
for n=1:1:numel(exp)
    for i=1:1:size(w_x{n},2)
        % obter a janela através do blackman
        black_win = blackman(numel(w_x{n}{i}));
        m = abs(fftshift(fft(detrend(w_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % apresentar a data obtida através das 3 dimensoes.
        scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(w_up_x{n},2)
        black_win = blackman(numel(w_up_x{n}{i}));
        m = abs(fftshift(fft(detrend(w_up_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_up_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_up_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(w_down_x{n},2)
        black_win = blackman(numel(w_down_x{n}{i}));
        m = abs(fftshift(fft(detrend(w_down_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_down_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_down_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(sit_x{n},2)
        black_win = blackman(numel(sit_x{n}{i}));
        m = abs(fftshift(fft(detrend(sit_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(stand_x{n},2)
        black_win = blackman(numel(stand_x{n}{i}));
        m = abs(fftshift(fft(detrend(stand_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(lay_x{n},2)
        black_win = blackman(numel(lay_x{n}{i}));
        m = abs(fftshift(fft(detrend(lay_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(stand2sit_x{n},2)
        black_win = blackman(numel(stand2sit_x{n}{i}));
        m = abs(fftshift(fft(detrend(stand2sit_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2sit_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2sit_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(sit2stand_x{n},2)
        black_win = blackman(numel(sit2stand_x{n}{i}));
        m = abs(fftshift(fft(detrend(sit2stand_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2stand_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2stand_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(sit2lay_x{n},2)
        black_win = blackman(numel(sit2lay_x{n}{i}));
        m = abs(fftshift(fft(detrend(sit2lay_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2lay_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2lay_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(lay2sit_x{n},2)
        black_win = blackman(numel(lay2sit_x{n}{i}));
        m = abs(fftshift(fft(detrend(lay2sit_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2sit_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2sit_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(stand2lay_x{n},2)
        black_win = blackman(numel(stand2lay_x{n}{i}));
        m = abs(fftshift(fft(detrend(stand2lay_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2lay_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2lay_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(lay2stand_x{n},2)
        black_win = blackman(numel(lay2stand_x{n}{i}));
        m = abs(fftshift(fft(detrend(lay2stand_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2stand_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2stand_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        % scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
end
view(40,35) % mudar a vista para apresentar o grafico 3d. 
grid on
hold off

%% Exercicio 4 - No ficheiro "Exercicio4.m"