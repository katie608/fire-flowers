
% Example MATLAB program that receives data from an Arduino 

% NOTE: While this is running, you can not re-program the Arduino.  You must exit 
% this MATLAB program before downloading a sketch to the Arduino.


% Set the name of the serial port
arduinoComPort = 'COM11';

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
        disp(fscanf(serialPort));

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
        disp(sprintf('t,ax,ay,az = %d,%d,%d,%d\n',[ti,axi,ayi,azi]));
        
        % put data values in array
        t(i) = ti;
        ax(i) = axi;
        ay(i) = ayi;
        az(i) = azi;
        
        i = i+1;
        
        %code for creating a trailing 2 second window
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

        
        
    end
    pause(0.5);
    timeout = timeout + 1;
end

