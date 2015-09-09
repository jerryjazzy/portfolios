function onset_t = detect_onsets(filepath, novelty_type, win_size, hop_size, w_c, medfilt_len, offset)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% March 2015
% --------------------
% Compute onsets from an audio file.
%
% Parameters
% ----------
% filepath : string
%       path to a .wav file
% novelty type : string
%       Type of novelty function - one of 'le', 'sf', 'cd'
%       'le' for log energy derivative
%       'sf' for spectral flux
%       'cd' for complex domain
% win_size : int
%       window size for novelty function (in samples)
% hop_size : int
%       hop size for novelty function (in samples)
% w_c : float
%       peak picking cutoff frequency for Butterworth filter (Hz)
% medfilt_len : int
%       peak picking length of the median filter used in adaptive threshold. (samples)
% offset : float
%       peak picking offset in adaptive threshold.
%
% Returns
% -------
% onset t : 1 x P array
%       onset times (seconds)

[x_t,fs,t] = import_audio(filepath);

if(strcmp(novelty_type, 'sf'))
    [n_t_sf, t_sf, fs_sf] = compute_novelty_sf(x_t, t, fs, win_size, hop_size);
    [~, onset_t, ~, ~] = onsets_from_novelty(n_t_sf, t_sf, fs_sf, w_c, medfilt_len, offset);
elseif(strcmp(novelty_type, 'le'))
    [n_t_le, t_le, fs_le] = compute_novelty_le(x_t, t, fs, win_size, hop_size);
    [~, onset_t, ~, ~] = onsets_from_novelty(n_t_le, t_le, fs_le, w_c, medfilt_len, offset);
elseif(strcmp(novelty_type, 'cd'))
    [n_t_cd, t_cd, fs_cd] = compute_novelty_cd(x_t, t, fs, win_size, hop_size);
    [~, onset_t, ~, ~] = onsets_from_novelty(n_t_cd, t_cd, fs_cd, w_c, medfilt_len, offset);

else
    error('wrong input! please choose a type from le, sf and cd.');

end


end





