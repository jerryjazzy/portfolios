% Phase Distortion - Square Generator
% ---------------------
clear;

% parameters
M   =   4; % coefficient of oversampling
fs  =   44100;
dur =   1;
t   =   0:(1/fs):(dur-1/fs);
amp =   .5;
f0  =   622.253967; % fundamental frequency to produce
phaseOffset = - 2*pi/8;
ratio = (1 - (1/2+phaseOffset/pi))/2 ; % 0 ~ 1/2
numOfSamples = fs*M*dur;

scanningRatio = 10.614422; % ratio of scanning speed 

% % scan the wavetable in two different speeds
numOfSamplesPerCycle  = ((fs*M)/f0);
phase_incre = 2*pi*f0/(fs*M);
phase_inc_1 = phase_incre * (scanningRatio);
numOfSamples_1stPart = ceil(numOfSamplesPerCycle*ratio/scanningRatio);
phase_1stPart = numOfSamples_1stPart * phase_inc_1;
phase_inc_2 = (pi - phase_1stPart) / (numOfSamplesPerCycle/2-numOfSamples_1stPart);

phase = 0;
buffer = zeros(numOfSamples, 1);
for n = 1 : numOfSamples
    
    buffer(n) = amp * sin(phase+phaseOffset);
    
    if phase < 2*pi*ratio
        
        phase = phase + phase_inc_1;       
        
    elseif phase < pi
        phase = phase + phase_inc_2;
        
    elseif phase < pi+2*pi*ratio
        phase = phase + phase_inc_1;
    else
        phase = phase + phase_inc_2;
    end
        phase = mod(phase, 2*pi);
    
end

% LPF
cutoffFreq = 22000;
Wn = cutoffFreq/(fs*M/2);
n = 2;
[B, A] =  butter(n,Wn);
y = filter(B, A, buffer);

% downsampling
output = zeros(fs*dur,1);
for s = 0:fs*dur-1
    
    output(s+1) = y(s*M+1);
    
end

% plot
figure
subplot(2,1,1);
plot(buffer,'-ok');
title('oversampled signal');
xlim([0*round(numOfSamplesPerCycle)+1 1*round(numOfSamplesPerCycle)+1]);
subplot(2,1,2);
plot(output,'-o');
title('downsampled signal');
xlim([1*round(numOfSamplesPerCycle)/M+2 2*round(numOfSamplesPerCycle)/M+2]);

% output
output = 1*output;
sound(output,fs);
% audiowrite('/Users/Jerry/Desktop/pdtest.wav', output, fs);
