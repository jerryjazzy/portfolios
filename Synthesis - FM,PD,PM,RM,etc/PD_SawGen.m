% Phase Distortion - Sawtooth Generator
% ---------------------

clear;

% parameters
M = 4; % coefficient of oversampling
fs = 44100.0;
dur = 1;
t = 0:(1/fs):(dur-1/fs);
amp = .5;
f0 = 622.0; % fundamental frequency to produce
phaseOffset = -1*pi/2;
numOfSamples = fs*M*dur;

scanningRatio = 10.6333333;

% % scan the wavetable in two different speeds
numOfSamplesPerCycle = round((fs*M)/f0);
% 
phase_incre = 2*pi*f0/(fs*M);
phase_inc_1 = phase_incre * scanningRatio;
numOfSamples_1stPart = ceil(numOfSamplesPerCycle/2/scanningRatio);
phase_1stPart = numOfSamples_1stPart * phase_inc_1;
phase_inc_2 = (2*pi - phase_1stPart) / (numOfSamplesPerCycle-numOfSamples_1stPart);


% phase_incre = 2*pi*f0/(fs*M);
% phase_inc_1 = phase_incre * scanningRatio;
% phase_inc_2 = phase_incre * (scanningRatio/(scanningRatio*2-1));

%phase_inc_2 = (2*pi - ceil(bufferSize/2/scanningRatio) * phase_incre * scanningRatio) / (((fs*M)/f0) * (1 - 1/2/scanningRatio));

phase = 0;
buffer = zeros(numOfSamples, 1);
for n = 1 : numOfSamples
    
    buffer(n) = amp * sin(phase+phaseOffset);
    
    if phase < pi
        phase = phase + phase_inc_1;
        
%           if phase >= pi
%               phase = phase - phase_inc_1 + phase_inc_2;
%           end
%         
    else
        
        phase = phase + phase_inc_2;
    end
    
     phase = mod(phase, 2*pi);
    
end

% LPF
cutoffFreq = 22050;
Wn = cutoffFreq/(fs*M/2);
n = 4;
[B, A] =  butter(n,Wn);
y = filter(B, A, buffer);

% downsampling
output = zeros(fs*dur,1);
for s = 0:fs*dur-1
    
    output(s+1) = y(s*M+1);
    
end


figure
subplot(2,1,1);
plot(buffer,'-ok');
title('oversampled signal');
xlim([0*round(numOfSamplesPerCycle)+1 1*round(numOfSamplesPerCycle)+1]);
subplot(2,1,2);
plot(output,'-o');
title('downsampled signal');
xlim([1*round(numOfSamplesPerCycle)/M+2 2*round(numOfSamplesPerCycle)/M+2]);
output = 1*output;
sound(output,fs);
% audiowrite('/Users/Jerry/Desktop/pdtest.wav', output, fs);
