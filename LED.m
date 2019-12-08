% flashes LED light according to a frequency

frequency = 2;

% code that will turn the led on and off
for index = 1:(frequency*4)
     % need to run this only once when arduino is first connected
%     a = arduino();
    %"D" is pin, and 5 is voltage, Valid PWM pins are "D3", "D5-D6", "D9-D11".
    writePWMVoltage(a,'D3',5);
    writePWMVoltage(a,'D9',5);
    pause(1/(frequency));
    writePWMVoltage(a, 'D5',5);
    writePWMVoltage(a,'D10',5);
    writePWMVoltage(a,'D3',0);
    writePWMVoltage(a,'D9',0);
    pause(1/(frequency));
    writePWMVoltage(a, 'D6',5);
    writePWMVoltage(a,'D11',5);
    writePWMVoltage(a, 'D5',0);
    writePWMVoltage(a,'D10',0);
    pause(1/(frequency));
end
writePWMVoltage(a,'D3',0);
writePWMVoltage(a,'D9',0);
writePWMVoltage(a,'D5',0);
writePWMVoltage(a,'D10',0);
writePWMVoltage(a,'D6',0);
writePWMVoltage(a,'D11',0);