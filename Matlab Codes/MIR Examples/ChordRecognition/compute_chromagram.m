function [chromagram, t_chromagram] = compute_chromagram(filepath, win_size, hop_size, ...
b_p_o, n_octaves, f_min)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the chromagram of an audio file.
% 
% filepath  : The path of the audio file
% win_size  : The window size for the spectrogram
% hop_size  : The hop size for the spectrogram
% b_p_o     : Number of bins per octave
% n_octaves : Number of octaves considered for the chromagram
% f_min     : The center frequency value for the first filter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Read audio file
[x, fs] = import_audio(filepath);

% Build the spectrogram, delete the last row for compatibility issues
window = hamming(win_size);
spec = spectrogram(x, window, hop_size, 2*win_size, fs);
spec(length(spec(:,1)),:) = [];
spec = 20*log10(abs((spec))); % convert to dB

% Get the number of filters
num_filts = b_p_o * n_octaves;

% Get the center frequencies for the chroma filters
cf = zeros(1, num_filts);
for i = 1:length(cf)
    cf(i) = f_min * 2^((i-1)/b_p_o);
end

% Go to log-frequency domain to determine the start point for the first
% filter and the end point for the last filter, since center frequencies
% are linear in log-frequency.
log_cf = log2(cf);
startp = log_cf(1)-(log_cf(2)-log_cf(1));
endp   = log_cf(end)+(log_cf(end)-log_cf(end-1));

% Add the two points to the center frequencies vector
log_cf = [startp log_cf endp];

% Convert back to frequency domain
cf = 2.^log_cf;

% Find the indexes of the center frequencies in the spectrogram matrix
fbins = (1:win_size).*fs/2/win_size;
filtbank = zeros(num_filts, win_size);
center_freqs = find_nearest(fbins', cf);

% Construct the filter bank
for i = 1:num_filts
    % First and second halves of each filter will be of different lengths
    first = hamming(((center_freqs(i+1)-center_freqs(i))*2)+1);
    second = hamming(((center_freqs(i+2)-center_freqs(i+1))*2)+1);
    filtbank(i, (center_freqs(i):center_freqs(i+1)))...
                = first(1:center_freqs(i+1)-center_freqs(i)+1);
    filtbank(i, (center_freqs(i+1):center_freqs(i+2)))...
                = fliplr(second(center_freqs(i+2)-center_freqs(i+1)+1:end));
    
    % Normalize each filter to unity sum
    filtbank(i,:) = filtbank(i,:)/sum(filtbank(i,:));
end

% Multiply the filter matrix with the spectrogram
cq_spec = filtbank * spec;
chromagram = cq_spec;

% Do the folding process
for i = b_p_o+1 : b_p_o : (n_octaves-1)*b_p_o+1
    chromagram(1:b_p_o,:) = chromagram(1:b_p_o,:) + chromagram(i:i+b_p_o-1,:);
end

% Keep only the first b_p_o number of bins, and convert to dB
chromagram(b_p_o+1:end,:) = [];
% chromagram = log(chromagram);

% Time values for each time frame
t_chromagram = (1:length(chromagram(1,:)))/length(chromagram(1,:)).*length(x)/fs;
end