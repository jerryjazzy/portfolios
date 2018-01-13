function synth = KarplusStrong(freq, dur, amp, fs)
% Plucked String Simulation by Karplus-Strong Algorithm
% by Xiao Lu
% 8/12/2015
% --------------
% Parameters:
%   freq: fundamental frequency (e.g.440Hz for A4)
%   dur : duration of the output (e.g. 4 seconds)
%   amp : amplitude (0~1)
%   fs  : sampling frequency (normally 44100)
% --------------
% Result:
%   synth : the resulting synthesized signal. 
%         1 x (dur*fs) Vector.
% --------------


% Parameters
f0          = freq;	% fundamental frequency
decayCof    = .995; % the decay factor (0~1)

% Length of the delay line
delay = round(fs/f0); 

% Initialize by using a random sequence of signal (white noise) as the
% wavetable and store them into a Ring Buffer
ringBuf = zeros(1,round(dur*fs));
ringBuf(1:delay) = randn(1,delay);

% Build the filter according to the block diagram
a = [1 zeros(1,delay-1) -0.5*decayCof -0.5*decayCof];
b = [1];

% Generate the output waveform
synth = filter(b,a,ringBuf);

% To refine the signal, trim off the first random burst.
synth(1:delay) = [];

% Normalize and scale
synth = amp*(synth/max(abs(synth)));

% Plot
figure(1)
plot(synth);
sound(synth, fs);
figure(2)    
spectrogram(synth,hamming(2048),1024,2048,fs,'yaxis'); % spectral analysis
title('Spectrogram of the synthesis by Karplus-Strong Algorithm');

