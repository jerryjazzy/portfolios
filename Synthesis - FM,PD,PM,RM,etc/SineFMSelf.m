samplerate = 44100;
freq = 440.0;
phase = 0.0;
numSamples = samplerate / 2;
buffer = zeros(numSamples, 1);
I = 20; % I = D/M
amp = .5;

lastSample = 0;
for s = 1:numSamples
    
    phase = 2*pi*freq*s/samplerate;
    phase = mod(phase, 2*pi);
    phase_temp = I * sin(phase);
    phase_temp2 = mod(phase + phase_temp,2*pi);
    sample = amp * sin(phase_temp2);
    buffer(s) = sample;

end

% spectrogram(buffer,hamming(512), 256,512, sr);

obj = audioplayer(buffer, samplerate);
play(obj);
audiowrite('/Users/Jerry/Desktop/mySineFMSelf20.wav', buffer, samplerate);