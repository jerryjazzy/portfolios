function [] = create_novelty_plots(filepath, win_size, hop_size,w_c, medfilt_len, offset, ground_truth_filepath)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% March 2015
% --------------------
% Plot waveform, novelty functions, preprocessing steps, and onsets.
%
% Parameters
% ----------
% filepath : string
%       path to a .wav file
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
% ground_truth_filepath : string (optional)
%       path to a .mat file with ground truth onsets
%
% Returns
% -------
% None
% -----
% Upgrades:
% 1) Add a new subplot of the original waveform and show the ground truth
% *2) Adjust the onset circles to be at the height as the smoothed function

% load the mat file and adjust it a bit so that the returned vector can be
% properly used
load(ground_truth_filepath);
[M,N] = size(T);
if(M==1)
    A = [T; T];
    B = [-1*ones(length(T),1)';ones(length(T),1)'];
else
    A = [T'; T'];
    B = [-1*ones(length(T),1)';ones(length(T),1)'];
end

% load the wav file
[x_t,fs,t] = import_audio(filepath);
info = audioinfo(filepath);
t_max = t(end)+.1;
% plot the original waveform
figure;
subplot(4,1,1);
plot(t,x_t);
hold on
line(A,B,'Color','g');
hold off
xlim([0 t_max]) 
ylim('auto') 
legend('Waveform','Ground Truth Onsets');
title({'Original waveform:';info.Filename});

% perform the three functions separately
[n_t_le, t_le, fs_le] = compute_novelty_le(x_t, t, fs, win_size, hop_size);
[onset_a_le, onset_t_le, n_t_smoothed_le, thresh_le] = onsets_from_novelty(n_t_le, t_le, fs_le, w_c, medfilt_len, offset);
len = min([length(t_le) length(n_t_smoothed_le) length(thresh_le)]);
subplot(4,1,2);
plot(t_le,(n_t_le-min(n_t_le))./(max(n_t_le)-min(n_t_le)),'r');
hold on
plot(onset_t_le,onset_a_le,'ok');
hold on
plot(t_le(1:len),n_t_smoothed_le(1:len),'-k');
hold on
plot(t_le,thresh_le,':b','LineWidth',3);
hold on
line(A,B,'Color','g');
hold off
legend('novelty function','onset','smoothed line','thresh','true onset');
ylim([0 1])
xlim([0 t_max]) 
title('Log Energy Derivatives');


[n_t_sf, t_sf, fs_sf] = compute_novelty_sf(x_t, t, fs, win_size, hop_size);
[onset_a_sf, onset_t_sf, n_t_smoothed_sf, thresh_sf] = onsets_from_novelty(n_t_sf, t_sf, fs_sf, w_c, medfilt_len, offset);
len = min([length(t_sf) length(n_t_smoothed_sf) length(thresh_sf)]);
subplot(4,1,3);
% (n_t_sf-min(n_t_sf))./(max(n_t_sf)-min(n_t_sf))
plot(t_sf,(n_t_sf-min(n_t_sf))./(max(n_t_sf)-min(n_t_sf)),'r');
hold on
plot(onset_t_sf,onset_a_sf,'ok');
hold on
plot(t_sf(1:len),n_t_smoothed_sf(1:len),'-k');
hold on
plot(t_sf,thresh_sf,':b','LineWidth',3);
hold on
line(A,B,'Color','g');
hold off
legend('novelty function','onset','smoothed line','thresh','true onset');
ylim([0 1])
xlim([0 t_max]) 
title('Spectral Flux');


[n_t_cd, t_cd, fs_cd] = compute_novelty_cd(x_t, t, fs, win_size, hop_size);
[onset_a_cd, onset_t_cd, n_t_smoothed_cd, thresh_cd] = onsets_from_novelty(n_t_cd, t_cd, fs_cd, w_c, medfilt_len, offset);
subplot(4,1,4);
len = min([length(t_cd) length(n_t_smoothed_cd) length(thresh_cd)]);
plot(t_cd,(n_t_cd-min(n_t_cd))./(max(n_t_cd)-min(n_t_cd)),'r');
hold on
plot(onset_t_cd,onset_a_cd,'ok');
hold on
plot(t_cd(1:len),n_t_smoothed_cd(1:len),'-k');
hold on
plot(t_cd,thresh_cd,':b','LineWidth',3);
hold on
line(A,B,'Color','g');
hold off
legend('novelty function','onset','smoothed line','thresh','true onset');
ylim([0 1])
xlim([0 t_max]) 
title('Complex Domain');


end