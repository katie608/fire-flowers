

s = serial('COM11','BaudRate',9600);
t = [];
ax = [];
ay = [];
az = [];
fopen(s);
readData=fscanf(s); %reads "Ready" 
 for i=1:150 %read lines of data
    readData=fgetl(s);
    disp(readData)
    d = strsplit(readData, ",");
    disp(d)
    
    t(i) = str2double(d(1));
    ax(i) = str2double(d(2));
    ay(i) = str2double(d(3));
    az(i) = str2double(d(4));
 end
fclose(s);
delete(s);


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

