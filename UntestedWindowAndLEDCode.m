% note: none of this is actually tested yet

% code that will hopefully turn the led on and off
for index = 1:(1/frequency) 
    % a = arduino, "D1" is pin, and 5 is voltage
    writePWMVoltage(a,'D1',5);
    pause(1/(frequency));
    writePWMVoltage(a, 'D1',0);
    pause(1/(frequency));
end

% code for creating a trailing 2 second window
window = 2000; % window time in ms
currentIndex = t(length(t))
currentTime = currentIndex;
twoSecondsAgo = currentTime-2000;
indexTwoSecondsAgo = find(t=twoSecondsAgo);
axWindow = ax(indexTwoSecondsAgo:currentIndex);
ayWindow = ay(indexTwoSecondsAgo:currentIndex);
azWindow = az(indexTwoSecondsAgo:currentIndex);

