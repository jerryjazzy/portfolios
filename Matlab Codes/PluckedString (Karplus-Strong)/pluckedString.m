function synth = pluckStr(len, dur, height, pluck, pickup, fs)
% Plucked String Simulation by Physical Modeling
% by Xiao Lu
% 8/12/2015
% --------------
% Parameters:
%   len: length of the string related to fundamental frequency (e.g.440Hz for A4)
%   dur : duration of the output (e.g. 4 seconds)
%   height : The height of initial condition at the plucking point of string (0~1)
%   pluck: the position where the string is plucked (0~1)
%   pickup: the position where the sound is picked up / heard (0~1)
%   fs  : sampling frequency (e.g. 44100)
% --------------
% Result:
%   synth : the resulting synthesized signal. 
%         1 x (dur*fs) Vector.
% --------------


output = zeros(dur*fs,len); %The sum of right and left travelling sound
pluckIdx = round(len*pluck); %The point where vibration is plucked
pickupIdx = round(len*pickup); %The point where vibration is picked up in string
dampCof = .996 ;% decay factor

%Initialization
delta1 = height/pluckIdx;
delta2 = height/(len - pluckIdx);

right = [ 0:delta1:height-delta1, height:-delta2:0];
left = right;

figure(1)
plot(right)
figure(2)
plot(left)

%Start
for t = 1:dur*fs 
    
    rlast = right(len);
    nut = (-1)*left(1);
    right = [nut,right(1:len-1)];
    bridge = rlast* (-dampCof);
    left = [left(2:len),bridge];
    
    for j = 1:len
        output(t,j) = right(j)+left(j);
    end
    
end
synth = output(:,pickupIdx);

figure(3)
plot(synth) 
figure(4)
spectrogram(synth,hamming(1024),512,1024,fs,'yaxis');%spectral analysis
title('Spectrogram of the synthesis by simple physical modeling');
sound(synth,44100)