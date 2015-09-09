% --------------------
% Report #2
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% March 2015
% --------------------

%% Q1 
%% a)
% Use the parameters win size=1024, hop size=512, w c=4 Hz, medfilt len=8, offset=0.01.
clear;
win_size = 1024;
hop_size = 512;
w_c = 4;
medfilt_len = 8;
offset = 0.01;
% Here, comparing to the last version, this optimized version runs MUCH
% faster(20sec VS 4sec). Also, the result becomes more clear and accurate
% due to the use of the zero-phase filter and the removal of the early 
% normalization in each novelty function.
tic;
create_novelty_plots('PianoDebussy.wav', ...
    win_size, hop_size, w_c, medfilt_len, offset, 'PianoDebussy.mat');
create_novelty_plots('tabla.wav', ...
    win_size, hop_size, w_c, medfilt_len, offset, 'tabla.mat');
create_novelty_plots('Jaillet21.wav', ...
    win_size, hop_size, w_c, medfilt_len, offset, 'Jaillet21.mat');
create_novelty_plots('wilco.wav', ...
    win_size, hop_size, w_c, medfilt_len, offset, 'wilco.mat');
toc;
%% b)

tolerance = 0.05;

%%
load('PianoDebussy.mat');
ref_onsets = T;
filename = 'PianoDebussy.wav';   

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('tabla.mat');
filename = 'tabla.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
%%
load('Jaillet21.mat');
filename = 'Jaillet21.wav';   
ref_onsets = T;
type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('wilco.mat');
filename = 'wilco.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);


%% Q2
disp('Question 2');
%% 1)
disp('win_size = 512, hop_size = 256, w_c = 4Hz,medfilt_len = 8,offset = 0.01');
hop_size = 256; win_size = 512;
w_c = 4;
medfilt_len = 8;
offset = .01;
load('PianoDebussy.mat');
ref_onsets = T;
filename = 'PianoDebussy.wav';   

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('tabla.mat');
filename = 'tabla.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
%%
load('Jaillet21.mat');
filename = 'Jaillet21.wav';   
ref_onsets = T;
type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('wilco.mat');
filename = 'wilco.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%% 2)
disp('win_size = 1024, hop_size = 512, w_c = 8Hz,medfilt_len = 8,offset = 0.01');
hop_size = 512; win_size = 1024;
w_c = 8;medfilt_len = 8;

load('PianoDebussy.mat');
ref_onsets = T;
filename = 'PianoDebussy.wav';   

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('tabla.mat');
filename = 'tabla.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
%%
load('Jaillet21.mat');
filename = 'Jaillet21.wav';   
ref_onsets = T;
type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('wilco.mat');
filename = 'wilco.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
%% 3)
disp('win_size = 1024, hop_size = 512, w_c = 8Hz,medfilt_len = 15,offset = 0.01');
hop_size = 512; win_size = 1024;
w_c = 8;
medfilt_len = 15;
load('PianoDebussy.mat');
ref_onsets = T;
filename = 'PianoDebussy.wav';   

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('tabla.mat');
filename = 'tabla.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
%%
load('Jaillet21.mat');
filename = 'Jaillet21.wav';   
ref_onsets = T;
type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);

%%
load('wilco.mat');
filename = 'wilco.wav';   
ref_onsets = T;

type = 'le';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'sf';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);
type = 'cd';
est_onsets = detect_onsets(filename, type, win_size, hop_size, w_c, medfilt_len, offset);
[F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance);
X = ['The F, P and R for ',filename,' using ',type,' is ', ...
    num2str(F),', ',num2str(P),', ',num2str(R),' respectively.'];
disp(X);