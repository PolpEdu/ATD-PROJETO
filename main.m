close all
clear

User = {'01', '02', '03', '04', '05'};
Expr = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10'};

u = 1;
e = 1;

color = {'r'; 'b'; 'y'; 'w'; 'k'; 'g'; 'm'; 'c';'r'; 'b'; 'y'; 'w'; 'k'; 'g'; 'm'; 'c'};

Fs = 50; %Sampling frequency in Hz
activities = {'W', 'W\_U', 'W\_D', 'SIT', 'STAND', 'LAY', 'S\_SIT', 'S\_STAND', 'S\_lay', 'L\_SIT', 'S\_lay', 'L\_STAND'};

w_x = {{},{},{},{},{},{},{},{},{},{}};
w_y = {{},{},{},{},{},{},{},{},{},{}};
w_z = {{},{},{},{},{},{},{},{},{},{}};
 
w_up_x = {{},{},{},{},{},{},{},{},{},{}};
w_up_y = {{},{},{},{},{},{},{},{},{},{}};
w_up_z = {{},{},{},{},{},{},{},{},{},{}};
 
w_down_x = {{},{},{},{},{},{},{},{},{},{}};
w_down_y = {{},{},{},{},{},{},{},{},{},{}};
w_down_z = {{},{},{},{},{},{},{},{},{},{}};
 
sit_x = {{},{},{},{},{},{},{},{},{},{}};
sit_y = {{},{},{},{},{},{},{},{},{},{}};
sit_z = {{},{},{},{},{},{},{},{},{},{}};
 
stand_x = {{},{},{},{},{},{},{},{},{},{}};
stand_y = {{},{},{},{},{},{},{},{},{},{}};
stand_z = {{},{},{},{},{},{},{},{},{},{}};
 
lay_x = {{},{},{},{},{},{},{},{},{},{}};
lay_y = {{},{},{},{},{},{},{},{},{},{}};
lay_z = {{},{},{},{},{},{},{},{},{},{}};
 
stand2sit_x = {{},{},{},{},{},{},{},{},{},{}};
stand2sit_y = {{},{},{},{},{},{},{},{},{},{}};
stand2sit_z = {{},{},{},{},{},{},{},{},{},{}};
 
sit2stand_x = {{},{},{},{},{},{},{},{},{},{}};
sit2stand_y = {{},{},{},{},{},{},{},{},{},{}};
sit2stand_z = {{},{},{},{},{},{},{},{},{},{}};
 
sit2lay_x = {{},{},{},{},{},{},{},{},{},{}};
sit2lay_y = {{},{},{},{},{},{},{},{},{},{}};
sit2lay_z = {{},{},{},{},{},{},{},{},{},{}};
 
lay2sit_x = {{},{},{},{},{},{},{},{},{},{}};
lay2sit_y = {{},{},{},{},{},{},{},{},{},{}};
lay2sit_z = {{},{},{},{},{},{},{},{},{},{}};
 
stand2lay_x = {{},{},{},{},{},{},{},{},{},{}};
stand2lay_y = {{},{},{},{},{},{},{},{},{},{}};
stand2lay_z = {{},{},{},{},{},{},{},{},{},{}};
 
lay2stand_x = {{},{},{},{},{},{},{},{},{},{}};
lay2stand_y = {{},{},{},{},{},{},{},{},{},{}};
lay2stand_z = {{},{},{},{},{},{},{},{},{},{}};

sensors = {'ACC\_X', 'ACC\_Y', 'ACC\_Z'};

for n=1:1:10
    e = n;
    u = ceil(e/2);
    
    %Acel file name
    acc_file = sprintf('acc_exp%s_user%s.txt', Expr{e}, User{u});

    %Get Acel data
    dacc = import_raw_data(acc_file);

    %Get label info
    all_labels = import_labels('labels.txt');

    %Get labels for the current data file
    ix_labels = intersect(find(all_labels(:, 1) == str2num(Expr{e})), find(all_labels(:, 2) == str2num(User{u})));
    
    data = dacc;
    
    %create time vector
    t = [0: size(data, 1) - 1]./Fs;
    
    %Get data size
    [n_points, n_plots] = size(data);
    
    
    %Plot colored---------------------------------------------------------%
    figure;
    for i=1:n_plots
        subplot(n_plots, 1, i); plot(t./60, data(:, i), 'k--')
        axis([0, t(end)./60 min(data(:, i)) max(data(:, i))])
        xlabel('Time (min)');
        ylabel(sensors{i}); %lista com sensores
        hold on
        for j = 1 : numel(ix_labels)
            plot(t(all_labels(ix_labels(j), 4):all_labels(ix_labels(j), 5))./60, data(all_labels(ix_labels(j), 4):all_labels(ix_labels(j), 5), i));
            if mod(j, 2) == 1
                ypos = min(data(:, i)) - (0.2 * min(data(:, i)));
            else
                ypos = max(data(:, i)) - (0.2 * min(data(:, i)));
            end
            text(t(all_labels(ix_labels(j), 4))/60, ypos, activities{all_labels(ix_labels(j), 3)});
        end
    end
    
    
    %DFT------------------------------------------------------------------%
    
    for i=1:size(ix_labels,1)
         
        switch all_labels((ix_labels(i,1)),3)
            case 1
                temp = w_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                w_x{n} = temp;
 
                temp = w_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                w_y{n} = temp;
 
                temp = w_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                w_z{n} = temp;
 
            case 2
                temp = w_up_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                w_up_x{n} = temp;
 
                temp = w_up_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                w_up_y{n} = temp;
 
                temp = w_up_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                w_up_z{n} = temp;
 
            case 3
                temp = w_down_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                w_down_x{n} = temp;
 
                temp = w_down_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                w_down_y{n} = temp;
 
                temp = w_down_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                w_down_z{n} = temp;
 
            case 4
                temp = sit_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                sit_x{n} = temp;
 
                temp = sit_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                sit_y{n} = temp;
 
                temp = sit_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                sit_z{n} = temp;
 
            case 5
                temp = stand_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                stand_x{n} = temp;
 
                temp = stand_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                stand_y{n} = temp;
 
                temp = stand_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                stand_z{n} = temp;
 
            case 6
                temp = lay_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                lay_x{n} = temp;
 
                temp = lay_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                lay_y{n} = temp;
 
                temp = lay_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                lay_z{n} = temp;
 
            case 7
                temp = stand2sit_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                stand2sit_x{n} = temp;
 
                temp = stand2sit_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                stand2sit_y{n} = temp;
 
                temp = stand2sit_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                stand2sit_z{n} = temp;
 
            case 8
                temp = sit2stand_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                sit2stand_x{n} = temp;
 
                temp = sit2stand_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                sit2stand_y{n} = temp;
 
                temp = sit2stand_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                sit2stand_z{n} = temp;
 
            case 9
                temp = sit2lay_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                sit2lay_x{n} = temp;
 
                temp = sit2lay_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                sit2lay_y{n} = temp;
 
                temp = sit2lay_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                sit2lay_z{n} = temp;
 
            case 10
                temp = lay2sit_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                lay2sit_x{n} = temp;
 
                temp = lay2sit_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                lay2sit_y{n} = temp;
 
                temp = lay2sit_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                lay2sit_z{n} = temp;
 
            case 11
                temp = stand2lay_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                stand2lay_x{n} = temp;
 
                temp = stand2lay_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                stand2lay_y{n} = temp;
 
                temp = stand2lay_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                stand2lay_z{n} = temp;
 
            case 12  
                temp = lay2stand_x{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),1);
                lay2stand_x{n} = temp;
 
                temp = lay2stand_y{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),2);
                lay2stand_y{n} = temp;
 
                temp = lay2stand_z{n};
                temp{size(temp,2)+1} = data(all_labels(ix_labels(i,1),4):all_labels(ix_labels(i,1),5),3);
                lay2stand_z{n} = temp;
            otherwise
        end
    end
end


%Passos-------------------------------------------------------------------%
%(+features atividades dinamicas)

%Arrays steps/sec
steps_w = [];
steps_wup = [];
steps_wdown = [];

%Total steps (CADA PARCELA E UM FICHEIRO)
total_steps_w = zeros(10,1);
total_steps_wup = zeros(10,1);
total_steps_wdown = zeros(10,1);

for n=1:1:10
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

%media steps por minuto
media_steps_w_sec = mean(steps_w);
media_steps_wup_sec = mean(steps_wup);
media_steps_wdown_sec = mean(steps_wdown);


close all

%Features-----------------------------------------------------------------%

figure();
hold on

for n=1:1:10
    for i=1:1:size(w_x{n},2)
        black_win = blackman(numel(w_x{n}{i}));
        m = abs(fftshift(fft(detrend(w_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(w_up_x{n},2)
        black_win = blackman(numel(w_up_x{n}{i}));
        m = abs(fftshift(fft(detrend(w_up_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_up_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_up_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(w_down_x{n},2)
        black_win = blackman(numel(w_down_x{n}{i}));
        m = abs(fftshift(fft(detrend(w_down_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_down_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(w_down_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(sit_x{n},2)
        black_win = blackman(numel(sit_x{n}{i}));
        m = abs(fftshift(fft(detrend(sit_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(stand_x{n},2)
        black_win = blackman(numel(stand_x{n}{i}));
        m = abs(fftshift(fft(detrend(stand_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(lay_x{n},2)
        black_win = blackman(numel(lay_x{n}{i}));
        m = abs(fftshift(fft(detrend(lay_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(stand2sit_x{n},2)
        black_win = blackman(numel(stand2sit_x{n}{i}));
        m = abs(fftshift(fft(detrend(stand2sit_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2sit_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2sit_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(sit2stand_x{n},2)
        black_win = blackman(numel(sit2stand_x{n}{i}));
        m = abs(fftshift(fft(detrend(sit2stand_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2stand_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2stand_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(sit2lay_x{n},2)
        black_win = blackman(numel(sit2lay_x{n}{i}));
        m = abs(fftshift(fft(detrend(sit2lay_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2lay_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(sit2lay_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(lay2sit_x{n},2)
        black_win = blackman(numel(lay2sit_x{n}{i}));
        m = abs(fftshift(fft(detrend(lay2sit_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2sit_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2sit_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(stand2lay_x{n},2)
        black_win = blackman(numel(stand2lay_x{n}{i}));
        m = abs(fftshift(fft(detrend(stand2lay_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2lay_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(stand2lay_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
    
    for i=1:1:size(lay2stand_x{n},2)
        black_win = blackman(numel(lay2stand_x{n}{i}));
        m = abs(fftshift(fft(detrend(lay2stand_x{n}{i}).*black_win)));
        [m_x, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2stand_y{n}{i}).*black_win)));
        [m_y, ~] = findpeaks(m);
        m = abs(fftshift(fft(detrend(lay2stand_z{n}{i}).*black_win)));
        [m_z, ~] = findpeaks(m);
        %scatter3(m_x(1), m_y(1), m_z(1), 'o');
    end
end

hold off
