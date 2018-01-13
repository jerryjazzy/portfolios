% Ring Modulation

fs  =   44100;
dur =   1;
t   =   0:(1/fs):(dur-1/fs);
amp =   .8;
f1  =   440;
f2  =   660;

sig1 = amp * sin(2*pi*f1.*t);
sig2 = amp * sin(2*pi*f2.*t);

out = sig1 .* sig2;

sound(out,fs);

% the resultant signal contains two frequencies: (f2-f1) and (f2+f1)
% NOTE: the only difference between an RM and AM is that in AM the carrier
% is multiplied by (1+mod) such that the output still has the original
% frequency component(s).

