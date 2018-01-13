function underwater = underwater_(irFilename, signalFilename)

% read the files
ir = audioread(irFilename);
signal= audioread(signalFilename);

% convert to mono
ir = ir(:,1);
signal = signal(:,1);

% compute the length
irLength = length(ir);
signalLength = length(signal);
totalLength = length(ir)+ length(signal)-1;

% zero-padding so that the lengths are identical
ir=[ir;zeros(totalLength - irLength ,1)];
signal =[signal; zeros(totalLength - signalLength, 1)];
underwater = ifft(fft(ir).*fft(signal));


% normalization
underwater = underwater/max(abs(underwater));
    
end
