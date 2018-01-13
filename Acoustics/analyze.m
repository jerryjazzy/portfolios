%% Script for analysis
% by Xiao Lu
% 8/12/2015

%% A2 (110.0Hz) on the guitar string
[sig_A, fs2] = audioread('5th_String_A.aiff');
tVec2 = 0: 1/fs2 : length(sig_A)/fs - 1/fs; 
figure; 
plot(tVec2, sig_A);
xlim([1.4, length(sig_A)/fs2- 1/fs2]);
title('Waveform - A2(110.0Hz)');
figure;
spectrogram(sig_A,hamming(2048),1024,2048,fs2,'yaxis'); % spectral analysis
xlim([1.4, length(sig_A)/fs2- 1/fs2]);
ylim([0, 5000]);
title('Spectrogram - A2(110.0Hz)');

%% E4 (329.6Hz) on the guitar string
[sig_E, fs1] = audioread('1st_String_E.aiff');
tVec1 = 0: 1/fs1 : length(sig_E)/fs1 - 1/fs1; 
figure; 
plot(tVec1, sig_E);
xlim([1.9, length(sig_E)/fs1- 1/fs1]);
title('Waveform - E4(110.0Hz)');
figure;
spectrogram(sig_E,hamming(2048),1024,2048,fs1,'yaxis'); % spectral analysis
xlim([1.9, length(sig_E)/fs1- 1/fs1]);
ylim([0, 5000]);
title('Spectrogram - E4(329.6Hz)');

%% 1st Method
% 110Hz
synth1 = pluckStr(200, 10, .5, .5, .5, 44100);
ylim([0, 5000]);
audiowrite('Method1_A2.wav',synth1,fs);

%% 329Hz
synth2 = pluckStr(67, 10, .5, .5, .5, 44100);
ylim([0, 5000]);
audiowrite('Method1_E4.wav',synth2,fs);

%% 2nd Method (KS Algorithm)
% 110Hz
synth3 = KarplusStrong(110, 5, 1, 44100);
ylim([0, 5000]);
audiowrite('Method2_A2.wav',synth3,fs);

%% 329Hz
synth4 = KarplusStrong(329.6, 5, 1, 44100);
ylim([0, 5000]);
audiowrite('Method2_E4.wav',synth4,fs);
