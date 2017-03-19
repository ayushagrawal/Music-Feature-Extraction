function [ bank ] = melFilt( n,nfft )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
lower_freq = 500;
higher_freq = 22050;
numPoints = n+2;

lower_freq = 1125*log(1 + lower_freq/700);
higher_freq = 1125*log(1 + higher_freq/700);

mel_freq = zeros(numPoints,1);
step = (higher_freq - lower_freq)/(numPoints-1);
for i=0:numPoints-1
   mel_freq(i+1) = lower_freq + i*step;
end

freq = 700*(exp(mel_freq/1125)-1);
freq = floor(nfft.*freq/22050);
bank = zeros(freq(end),n);

for i = 1 : n
    for j = 1:freq(end)
        if j < freq(i) 
            bank(j,i) = 0;
        elseif j <= freq(i+1)
            bank(j,i) = (j - freq(i))/(freq(i+1)-freq(i));
        elseif j <= freq(i+2)
            bank(j,i) = (freq(i+2)-j)/(freq(i+2)-freq(i+1));
        else
            bank(j,i) = 0;
        end    
    end
end    
end

