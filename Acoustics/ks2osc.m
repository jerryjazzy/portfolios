function y=ks2osc(note,fs)
% Karplus-Strong plucked string instrument (refined version for more precise frequency)
%
% note is in duration-frequency-amplitude format

% Parameters
f0 = note(2);	%pitch
f=0.5;			%filter constant (0<f<0.5; higher f => longer duration)
dur = note(1);			%total duration of waveform

% Length of the delay line
N=floor(fs/f0 - 1/2);
delta=fs/f0 - 1/2 - N;
C=(1-delta)/(1+delta);


% Set up the input signal (burst of random noise for N samples, then zero
% after that)
x=zeros(1,round(dur*fs));
x(1:N)=randn(1,N);

% Set up the filter structure
a=[1 C zeros(1,N-2) -C/2 -(1+C)/2 -1/2];
b=[1 C];

% Generate the output waveform
y=filter(b,a,x);

% Trim off the original noise burst (valid signal is after the first N outputs)
y(1:N)=[];

% Normalize output, then scale by amplitude
y=note(3)*(y/max(abs(y)));
