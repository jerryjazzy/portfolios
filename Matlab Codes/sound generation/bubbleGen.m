
function signal =  bubbleGen(f0, S,a)
%f0 is from 200-10k hz
%S affects the slop of the rising of the pitch (from 0.1-10)
%a is the amplitude
fs = 44100;
t = 0:(1/fs):0.2;

d = 0.043*f0 + 0.0014*f0.^(3/2);
f = f0*(1+S*d.*t);
ir = a * sin(2*pi.*f.*t) .* exp(-d.*t);
signal = ir;

end



