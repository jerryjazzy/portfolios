% PHASE DISTORTION
% ----------------

% parameters
M = 8; % coefficient of oversampling
fs = 44100;
dur = .8;
t = 0:(1/fs):(dur-1/fs);
amp = .2;
freq = 440;
phaseOffset = -pi/2;
scanningRatio = 1000/1;% rate of scanning 0~pi : rate of scanning pi~2pi
cutoffFreq = 18000;

% calculate the wavetable of one cycle of the sine wave
tableSize = round(fs*M/freq); % NOT PROPER!
proportion1 = 1/(scanningRatio+1);
size1 = round(tableSize * proportion1);
size2 = tableSize - size1;
phase1 = phaseOffset + (0: pi/(size1-1) : pi);
phase2 = phaseOffset + (pi: pi/(size2-1) : 2*pi);
wavetable = zeros(1,tableSize);
wavetable(1:size1) = amp * sin(phase1);
wavetable(size1+1:tableSize) = amp * sin(phase2);

% generate the output signal
outputTemp = zeros(1,fs*dur);
for i = 0:fs*M/tableSize
    
    outputTemp(1+i*tableSize:i*tableSize+tableSize) = wavetable;
    
end

% LPF
Wn = cutoffFreq/(fs*M/2);
n = 2;
[B, A] =  butter(n,Wn);
y = filter(B, A, outputTemp);

% downsampling
output = zeros(fs,1);
for s = 0:fs-1
    
    output(s+1) = y(s*M+1);
    
end

plot(output,'-o');
xlim([1 tableSize/M]);
sound(output,fs);
audiowrite('/Users/Jerry/Desktop/PhaseDistortion80.wav', output, fs);
