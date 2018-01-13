function [synth, fs_synth] = channel_vocoder(carrier_path, modul_path, ...
    numOfChans, numOfBands, hop_size)
% The function performs the channel vocoder that modulates the carrier
% signal with the modulator.
% ----------
% by Xiao Lu
% N18993923
% May 2015
% ---------
% Parameters:
% ---------
% carrier_path: string
%   filepath of the carrier signal
% modul_path: string
%   filepath of the modulator
% numOfChans: int
%   number of channels         (e.g.256,512,1024)
% numOfBands: int
%   number of bands (<chan) (e.g., 8,20, 32, 128)
% hop_size: int
%   hop size for the spectrogram (e.g. 256 512)
% ---------
% Return:
% ---------
% synth: array
%   the synthesized waveform
% fs_synth: int
%   the sampling rate of the output
% ---------
% Example:
% [synth, fs_synth] = channel_vocoder('carrier.wav', 'modulator.wav', 512, 32, 512);
% sound(synth, fs_synth); % play the sound
% audiowrite('chanVoc.wav', synth, fs_synth); % produce the audio file

% error checking
if nargin ~=5,
    error('no. of arguments must be five') ;
end
if numOfBands>numOfChans,
    error('no. of bands must be no more than no. of channels');
end

% read in the two files
[carrier, fs_c] = audioread(carrier_path);
[modul,fs_m] = audioread(modul_path);

% check if the sampling rate match
if fs_c ~= fs_m
    error('your sampling rates are not the same');
end

% convert to one channel if the signal is stereo
carrier = mean(carrier,2);
modul = mean(modul,2);

% shorten the longer one between the carrier and the modulator
len        = min(length(carrier),length(modul));
carrier    = carrier(1:len);
modul      = modul(1:len);

% calculate the indices of the bands
band_idx = round(linspace(1,numOfChans+1,numOfBands+1));
win_size  = 2*numOfChans;

% build the filterbank matrix
filterBank = zeros(numOfBands, numOfChans+1);
for i = 1:numOfBands
    filt_length = band_idx(i+1) - band_idx(i) +1;
    windowFunc = ones(1,filt_length)/filt_length;
    filterBank(i,band_idx(i):band_idx(i+1)) = windowFunc;
end

% perform the spectrogram
noverlap = win_size - hop_size;
[S_mod] = spectrogram(modul,hamming(win_size),noverlap,win_size,fs_m);
% rectification and smoothing using the filterbank of square windows
S_rec = abs(S_mod);
envelope = filterBank * S_rec; % numOfBands x NT

% perform the spectrogram on the carrier
[S_car] = spectrogram(carrier,hamming(win_size),noverlap,win_size,fs_c);

% synthesis 
[NF,NT] = size(S_car);
S_synth = zeros(NF,NT);
synth = zeros(len,1);
for t = 1:NT
    for i = 1:numOfBands
        S_synth(band_idx(i):band_idx(i+1),t) = envelope(i,t) * S_car(band_idx(i):band_idx(i+1),t);
    end
    temp_syn  = [S_synth(:,t); flipud( conj( S_synth(1:end-1,t) ) );];
    temp_frame = real(ifft(temp_syn));
    startPos = 1 +((t-1)*hop_size);
    endPos =   1 +((t-1)*hop_size)+ win_size ;
    synth(startPos:endPos) = temp_frame;
end

% normalize the output
synth = synth/max(abs(synth));
fs_synth = fs_m;

% EOF
end