samplerate = 44100;
freq = 440.0;
increModulator = 2 * pi * freq / samplerate;
phaseModulator = 0.0;
incre = 2 * pi * freq / samplerate;
phase = 0.0;
numSamples = samplerate / 2;
buffer = zeros(numSamples, 1);
modulationIndex = 90.0;

for s = 1:numSamples

    %modulator
    sampleModulator = sin(phaseModulator);
    phaseModulator = mod(phaseModulator + increModulator, 2 * pi);
    
    %carrier
    %set freq
    carrierFreq = freq + sampleModulator * modulationIndex;
    incre = 2 * pi * carrierFreq / samplerate;
    sample = sin(phase) * 0.5; 
    phase = mod(phase + incre, 2 * pi);
    
    buffer(s) = sample;
end

obj = audioplayer(buffer, samplerate);
play(obj);
% audiowrite('/Users/Jerry/Desktop/mySineFM.wav', buffer, samplerate);