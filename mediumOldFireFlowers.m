arduinoComPort = 'COM15';

% Set the baud rate
% NOTE1: The baudRate for the sending and receiving programs must be the same!
% NOTE2: Set the baudRate to 115200 for faster communication
baudRate = 9600;

% open the serial port, close it first in case it was previously open
% need to comment this line the first time you run this after opening
fclose(instrfind({'Port','Status'},{arduinoComPort,'open'}));
serialPort = serial(arduinoComPort, 'BAUD', baudRate);
fopen(serialPort);
fprintf(serialPort, '\n');

% initialize a timeout in case MATLAB cannot connect to the arduino
timeout = 0;

% tic
tic

% initialize arrays to store last 2 seconds of data
t = [];
ax = [];
ay = [];
az = [];
i = 1;

% main loop to read data from the Arduino, then display it
while timeout < 5
    % check if data was received
    while serialPort.BytesAvailable > 0
        % reset timeout
        timeout = 0;
        
        % data was received, convert it into array of integers
        disp(fscanf(serialPort)); % this needs to run for it to work

        % read values as character strings from serial port
        valuesChar = fscanf(serialPort);
        
        %convert
        values = str2num(valuesChar);
        
%         values = eval(strcat('[', fscanf(serialPort), ']'));


        % if you want to store the integers in four variables
        ti = values(1);
        axi = values(2);
        ayi = values(3);
        azi = values(4);
        
        
        % print the results
        %disp(sprintf('t,ax,ay,az = %d,%d,%d,%d\n',[ti,axi,ayi,azi]));
%         disp("")
        
        % put data values in array
        t(i) = ti;
        ax(i) = axi;
        ay(i) = ayi;
        az(i) = azi;
        
        i = i+1;
        


        if mod(toc, 1) < 0.1
            disp("Got here")
            % create a trailing 2 second window
            window = 2000; % window time in ms
            currentIndex = length(t);
            currentTime = t(length(t));
            twoSecondsAgo = currentTime-2000;
            % finds closest value to two seconds ago
            [m, in2] = min(abs(t-twoSecondsAgo));
            tWindow = t(in2:currentIndex);
            axWindow = ax(in2:currentIndex);
            ayWindow = ay(in2:currentIndex);
            azWindow = az(in2:currentIndex);
            plot(tWindow, azWindow)
            drawnow
            
            % this takes the dft and finds the frequency
            N = length(tWindow);
            Fs = 20;
            f_double = linspace(-Fs/2, Fs/2 - Fs/N, N) + Fs/(2*N)*mod(N, 2);
            half_length = floor(length(f_double)/2);
            f = f_double(length(f_double)-half_length + 1:end);
            AZ_double = fft(azWindow);
            AZ = AZ_double(1:half_length);
            plot(f,abs(AZ))
            drawnow
            
            [sorted_AZ,ind] = sort(AZ, 'descend');
            max_ind = ind(2);
            mainFrequency = f(max_ind);
            disp("The Main Frequency: " +mainFrequency)
            
        end
        
    end
%     pause(0.5);
    timeout = timeout + 1;
end