function y = KarplusStrong(freq, dur, amp, fs)
% Karplus-Strong Algorithm Demonstration
% by Xiao Lu
% 8/12/2015
% --------------
% Parameters:
%   freq: fundamental frequency (e.g.440Hz for A4)
%   dur : duration of the output (e.g. 4 seconds)
%   amp : amplitude (0~1)
%   fs  : sampling frequency (normally 44100)
% --------------
% Output:
%   y   : the resulting signal. 
%         1 x (dur*fs) Vector.




% Parameters
f0          = freq;	% fundamental frequency
decayCof    = .996; % the decay factor (0~1)

% Length of the delay line
delay=round(fs/f0); 

% Set up the input signal (burst of random noise for N samples, then zero
% after that)
x=zeros(1,round(dur*fs));
x(1:delay)=randn(1,delay);

% Set up the filter structure
a=[1 zeros(1,delay-1) -0.5*decayCof -0.5*decayCof];
b=[1];

% Generate the output waveform
y=filter(b,a,x);

% Trim off the original noise burst (valid signal is after the first N outputs)
y(1:delay)=[];

% Normalize output, then scale by amplitude
y= amp*(y/max(abs(y)));
plot(y)
