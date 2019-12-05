
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
% fclose(instrfind({'Port','Status'},{arduinoComPort,'open'}));
serialPort = serial(arduinoComPort, 'BAUD', baudRate);
fopen(serialPort);
fprintf(serialPort, '\n');

% initialize a timeout in case MATLAB cannot connect to the arduino
timeout = 0;

% main loop to read data from the Arduino, then display it
while timeout < 5
    % check if data was received
    while serialPort.BytesAvailable > 0
        % reset timeout
        timeout = 0;
        
        % data was received, convert it into array of integers
        values = strcat('[', fscanf(serialPort), ']');
        
%         values = eval(strcat('[', fscanf(serialPort),']'));

        % if you want to store the integers in four variables
        t = values(1);
        ax = values(2);
        ay = values(3);
        az = values(4);
        
        % print the results
        disp(sprintf('t,ax,ay,az = %d,%d,%d,%d\n',[t,ax,ay,az]));
        
    end
    pause(0.5);
    timeout = timeout + 1;
end

