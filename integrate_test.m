% s = serial('COM11','BaudRate',9600);
t = [];
% ax = [];
% ay = [];
az = [];
% fopen(s);
% readData=fscanf(s); %reads "Ready" 

time = linspace(1,10000,10000);
all_azs = sin(time);

i = 1;
tic

while i < 30
    %read some number of lines of data (below)
    
%     t(i) = str2double(d(1));
%     ax(i) = str2double(d(2));
%     ay(i) = str2double(d(3));
%     az(i) = str2double(d(4));
    t(i) = time(i);
    az(i) = all_azs(i);
    disp(toc)
    
    if mod(toc,1) < 0.1
        disp("there")
        %code for creating a trailing 2 second window
        window = 2000; % window time in ms
        currentIndex = length(t);
        currentTime = t(length(t)-1);
        twoSecondsAgo = currentTime-2000;
        % finds closest value to two seconds ago
        [m, in2] = min(abs(t-twoSecondsAgo));
        axWindow = ax(in2:currentIndex);
        ayWindow = ay(in2:currentIndex);
        azWindow = az(in2:currentIndex);
        
        %dft
        %update frequency variable
    end
    
    %another toc-related if statement for sending led signals
    
    i = i + 1;
    
    pause(0.1)
end


% fclose(s);
% delete(s);


