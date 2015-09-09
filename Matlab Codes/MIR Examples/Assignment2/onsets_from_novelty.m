function [onset_a, onset_t, n_t_smoothed, thresh] = ...
        onsets_from_novelty(n_t, t, fs, w_c, medfilt_len, offset)

% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% May 2015
% --------------------
% The function performs peak-picking of a novelty function.
% 
% Parameters:
% ----------
% n_t : 1*L array
%     Novelty function
% t: 1*L array
%     time points of n_t in seconds
% fs : float
%     sample rate of n_t
% w_c : float
%     cutoff frequqancy
% medfilt_len : int
%     Length of the median filter used in adaptive thresholding
% offset: float
%     Offset in adaptive threshold
% 
% Returns:
% ------------
% onset_a : 1*P array
%     onset amplitudes
% onset_t : 1*P array
%     time values of detected onsets
% n_t_smoothed : 1*L array
%     novelty function after smoothing
% thresh : 1*L array
%     adaptive threshold
%
% Pre-processing: 
% (1) smoothing using a lowpass first-order Butterworth filter and zero-phase filtering
% (2) normalizing so that the maximum value is 1, 
% (3) adaptive thresholding using the local median. 
% Updates:
%   Replaced the LPF (used last time) with a zero-phasing filter
%   Optimized the peak-picking function


f_c_norm =w_c/(fs/2); % normalized cut-off freq (e.g.w_c = 4Hz)
[b1,a1] = butter(1,f_c_norm); % First Order Low pass Butterworth filter
% n_t_filtered = filter(b1,a1,n_t); % LPF
n_t_filtered = filtfilt(b1,a1,n_t); % works this time

% normalization
n_t_normalized = n_t_filtered/max(abs(n_t_filtered));

% thresholding using a local median filter
f_m = medfilt1(n_t_normalized,medfilt_len);

% set the offset and then perform the adaptive thresholding
delta_m = offset + f_m;
temp = n_t_normalized - delta_m;
temp = (temp+abs(temp))/2;

% peak picking
[~,locs] = findpeaks(temp);

% returns/outputs:
onset_a = n_t_normalized(locs);
onset_t = t(locs);
thresh = delta_m;
n_t_smoothed = n_t_normalized;

end