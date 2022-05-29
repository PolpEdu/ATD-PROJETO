    clc
    clear
   
    % - 1 - Variaveis de Inicalizacao
    
    % ficheiros = ["Data\acc_exp31_user15.txt","Data\acc_exp32_user16.txt","Data\acc_exp33_user16.txt","Data\acc_exp34_user17.txt","Data\acc_exp35_user17.txt","Data\acc_exp36_user18.txt","Data\acc_exp37_user18.txt","Data\acc_exp38_user19.txt","Data\acc_exp39_user19.txt","Data\acc_exp40_user20.txt"];

    Exps={"21","22","23","24","25","26","27","28","29","30"}; % Array para os expr para os ficheiros
    Users = {"10","11","12","13","14","15"}; % Array para os users para os ficheiros
    Fs = 50; % - Frequência de amostragem no problema - %
    Sensors = {"ACC_X","ACC_Y","ACC_Z"}; % - Legendas dos graficos - %
    Activities = {"W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"};  % - Array das atitividades - %
   all_labels = importdata("HAPT Data Set/RawData/labels.txt"); % Importa a data das labels


    % - Variaveil auxiliar para permitir desenhar as figuras em simultaneo - %
    user_aux = 0;
    user = 1;
    
    for i=1:length(Exps)
        if (i ~=1 && i ~= length(Exps)) % - Se nao tiver nem no ultimo nem no primeiro - %
            % - Cada user tem duas exp - %
            if (user_aux == 1) % - Esta na segunda exp - %
                user_aux = 0;
            else % - Esta no primeiro exp - %
                user_aux = user_aux + 1; % - Incrementa a variavel auxiliar - %
                user = user + 1; % - Passa para um novo utilizador pois ja contou com os dois exp do usuario anterior - %
            end
        else % - Pimeiro / Ultimo elemento do array dos exp - %
            users = i; % - O valor e sempre igual a i - %
            if i == length(Exps) % - Ultimo elemento do array - %
                user = 6; % - Damos-lhe o ultimo elemento do array dos users - %
            end
        end
        
        % - 2 - Import dos sinais
        fich = sprintf("HAPT Data Set/RawData/acc_exp%s_user%s.txt",Exps{i},Users{user});
        data = importdata(fich);
        
        ix_labels = intersect(find(all_labels(:,1)==str2double(Exps{i})),find(all_labels(:,2)==str2double(Users{user}))); % - Labels para o ficheiro correspondente - %
        
        t=[0:size(data,1)-1]./Fs;
        [n_pontos,n_col] = size(data);
        Ts = 1/Fs;
        
        for k=1:n_col
            % - 3 - Representacao Grafica
            if(i == 1)
                figure(i)
            else
                figure(i+2)
            end
                
            subplot(n_col,1,k);
            plot(t./60,data(:,k),"k--")
            axis([0 t(end)./60 min(data(:,k)) max(data(:,k))])
            xlabel("Time(min)","fontsize",16,"fontweight","bold")
            ylabel(Sensors{k},"fontsize",16,"fontweight","bold")
            
            hold on
       
            for j=1:length(ix_labels) % - Da as labels ao grafico - %
                plot(t(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5))./60,data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),k))
                if (mod(j,2)) == 1 % - Verifica se deve ser em cima ou em baixo - %
                    ypos = min(data(:,k))-(0.2*min(data(:,k)));
                else
                    ypos = max(data(:,k))-(0.2*max(data(:,k)));
                end
                % - Escreve as labels - %
                text(t(all_labels(ix_labels(j),4))/60,ypos,Activities{all_labels(ix_labels(j),3)},"VerticalAlignment","top","HorizontalAlignment","left");       
            end
            
            % - 4 - Calculo da DFT
            x = abs(data(:,k));

            % - Janela de Hamming - %
            h = hamming(length(x));  
            X = fftshift(fft(x.*h));

           % wvtool(h)

            hold off
            figure(3)    
            N = numel(X);
            tt=linspace (0,(N-1)/Fs,N);
            plot(tt,X,"-")
            legend("");
            axis tight

            % - Backman Window - %
            b = blackman(length(x));
            Xx = fftshift(fft(x.*b));
            
         %   wvtool(b)

            figure(4)    
            plot(tt,Xx,"-")
            axis tight
            
            % - Flat Top Window - %
            f = flattopwin(length(x));
            XxX = fftshift(fft(x.*f));
            
         %   wvtool(f)
            
            figure(5)    
            plot(tt,XxX,"-")
            axis tight
            
            % - 4.2 - %
            walking = [];
            walkingUpstairs = [];
            walkingDownstairs = [];
            
            for j=1:length(ix_labels)
                if(Activities{all_labels(ix_labels(j),3)} == "W")
                    walking = [walking; data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),k)];
                end
                if(Activities{all_labels(ix_labels(j),3)} == "WU")
                    walkingUpstairs = [walkingUpstairs; data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),k)];
                end
                if(Activities{all_labels(ix_labels(j),3)} == "WD")
                    walkingDownstairs = [walkingDownstairs; data(all_labels(ix_labels(j),4):all_labels(ix_labels(j),5),k)];
                end
            end
            
            % - walking - %
            max_x = max(walking);
            min_mag = max_x - (0.2*max_x);
            [pksW,locsW] = findpeaks(walking,'MinPeakHeight',min_mag);
            
            pksWMin = pksW*60;
            mediaW = mean(pksWMin);
            desvioW = std(pksWMin);
            n_amostraW = length(pksW);
           
            % - walking upstairs - %
            max_x = max(walkingUpstairs);
            min_mag = max_x - (0.2*max_x);
            [pksWU,locsWU] = findpeaks(walkingUpstairs,'MinPeakHeight',min_mag);
            
            pksWUMin = pksWU*60;
            mediaWU = mean(pksWUMin);
            desvioWU = std(pksWUMin);
            n_amostraWU = length(pksWU);
            
            % - walking downstairs - %
            max_x = max(walkingDownstairs);
            min_mag = max_x - (0.2*max_x);
            [pksWD,locsWD] = findpeaks(walkingDownstairs,'MinPeakHeight',min_mag);
            
            pksWDMin = pksWD*60;
            mediaWD = mean(pksWDMin);
            desvioWD = std(pksWDMin);
            n_amostraWD = length(pksWD);
            
            % - Tabela - %
            Movimentos = ["Walking";"Walking Upstairs";"Walking Downstairs"];
            Media = [mediaW;mediaWU;mediaWD];
            Desvio_Padrao = [desvioW;desvioWU;desvioWD];
            N_De_Amostras = [n_amostraW;n_amostraWU;n_amostraWD];
            
            T = table(Movimentos,Media,Desvio_Padrao,N_De_Amostras)
            
        end

    end