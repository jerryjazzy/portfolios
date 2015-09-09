function [mfccs, fs_mfcc] = compute_mfccs(filepath, win_size, hop_size, ...
    min_freq, max_freq, num_mel_filts, n_dct)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
% Compute MFCCs from audio file.
% Parameters
% ----------
% filepath : string
%     path to .wav file 
% win_size : int
%     spectrogram window size (samples) 
% hop_size : int
%     spectrogram hop size (samples) 
% min_freq : float
%     minimum frequency in Mel filterbank (Hz) 
% max_freq : float
%     maximum frequency in Mel filterbank (Hz)
% num_mel_filts: int
%     number of Mel filters 
%    (a set of 20-40 triangular filters)
% n_dct: int
%     number of DCT coefficients
%     
% Returns
%  -------
% mfccs: ndct x NT array
%     MFCC matrix (NT is number spectrogram frames)
% fs_mfcc : int
%     sample rate of MFCC matrix (samples/sec)

% read in the waveform and compute the spectrogram
noverlap = win_size - hop_size;
[x_t, fs, t] = import_audio(filepath);
[S,F,T] = spectrogram(x_t,hamming(win_size),noverlap,win_size,fs);
% S = abs(S);

% create the mel-filterbank matrix 
% (windows are normalized to unity sum & evenly distributed over the mel scale)
min_mel = hz2mel(min_freq);
max_mel = hz2mel(max_freq);
filterbank_mel = min_mel:(max_mel - min_mel)/(num_mel_filts+2) : max_mel;
filterbank_hz = mel2hz(filterbank_mel);
filterbank_idx = find_nearest(F, filterbank_hz);
windowMat = zeros(num_mel_filts,length(F));
for i = 1:num_mel_filts
    windowSize = filterbank_idx(i+2)-filterbank_idx(i)+1;
    windowFunc = triang(windowSize)'/sum(triang(windowSize));
    windowMat(i,filterbank_idx(i):filterbank_idx(i+2)) = windowFunc;
end

% ?you should convert to dB before multiplying by the mel filter bank.
% compute the mel power spectrum in dB. 
mel_spectrum = windowMat * S;
mel_spectrum_db = 20*log10(abs(mel_spectrum));

% apply the DCT on each column of the mel spectrum
mfccs = zeros(n_dct,length(T));
for i = 1:length(T)
    tempMat = dct(mel_spectrum_db(:,i));
    mfccs(:,i) = tempMat(1:n_dct);
%    mfccs(:,i) = mfccs(:,i)/max(abs(mfccs(:,i))); % normalize
end

fs_mfcc = floor(fs/hop_size);

% optionally plot the MFCC
% figure;
% imagesc(T,1:n_dct,abs(mfccs));
% set(gca,'YDir','normal');

%EOF
end