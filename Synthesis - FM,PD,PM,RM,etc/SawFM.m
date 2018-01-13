samplerate = 44100;
freq = 440.0;
incre_ = 2 * pi * freq / samplerate;
phase_ = 0.0;
numSamples = samplerate / 2;
buffer = zeros(numSamples, 1);

for s = 1:numSamples
%  	sample = (1.0 - phase_ / pi) * 0.25;
	sampleModulator = 1.0 - phase_ / pi;
    modPhase = mod(phase_ + 16 * sampleModulator, 2 * pi);
    sample = (1.0 - modPhase / pi) * 0.15;
    
    buffer(s) = sample;

	phase_ = phase_ + incre_;
    if (phase_ > 2 * pi)
        phase_ = phase_ - 2 * pi;
    end
end

obj = audioplayer(buffer, samplerate);
play(obj);
audiowrite('/Users/shaoduo/Desktop/mySaw.wav', buffer, samplerate);
