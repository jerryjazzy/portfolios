% sawtooth using additive synthesis

M=4;
samplerate = 44100;
freq = 440.0;
phase_ = 0.0;
dur = 1;
numOfPartials = 32;


tableSize = 8192;
h = zeros(tableSize,1);
freq_bin = round(linspace(1,tableSize, numOfPartials*2));
for i = 1:numOfPartials*2
   h(freq_bin(i)) =  1;
end

x = real(ifft(h,tableSize));
wavetable = x/max(abs(x));
% 
% output = zeros(1,samplerate*dur);
% for i = 0:fs/tableSize
%     
%    output(1+i*tableSize:i*tableSize+tableSize) = wavetable;
%     
% end

% sound(output,samplerate);