function bubbles = liquidGen (nBub,duration,environment)
% generates a number of bubble sounds
% -------------------------------------
% Inputs:
% nBub: int
%   number of bubbles
% duration: float
%   duration of the sound
% environment: adding effects: "1"(cavedrop) or "2"(underwater) or "othernumbers"(dry)
% -------------------------------------
% Output:
% bubbles: array
%   the bubble waveform

fs = 44100;
sigLen = ceil(duration*fs); 
interval = 11000; % in samples
bubbles = zeros(1,sigLen);
S = .1; %can be changed (depend on the bubble type)
a = .8; %can be changed
for i = 1:nBub
    f0 = randi([500 3000]); 
    bubbleFunc = bubbleGen(f0, S,a);
    len = length(bubbleFunc);
    bubbles((i-1)*interval+1:(i-1)*interval+len) =  bubbleFunc; % put each single bubble into random positions over timeline
end

% add effects on liquid sound. 
% when environment=1, simulating the effects of the cave droping
% when environment=2, simulating the effects of the underwater
% when environment=othernumbers,no effects
  
if environment == 1;
   reverb=rev(bubbles,0.7,3);
   bubbles = bubbles+reverb;

elseif environment == 2
  
   bubbles=bubbles;
   % by convolving with an impulse response % fast convolution
   audiowrite('liquid.wav',bubbles,44100);
   underwater = underwater_('room_impulse.wav', 'liquid.wav');
   bubbles= underwater;
else
    bubbles=bubbles;
      
end

end