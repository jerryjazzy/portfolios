function [x_t, fs, t] = import_audio(filepath)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% March 2015
% --------------------
% the function reads any audio (wav) file and returns the signal x(t)
% the vector of time points t in seconds, and the sample rate fs.
% If the audio is stereo, the second channel should be disregarded. 
%--------------------
% Parameters: 
% filepath - the file path
%   String
%                 
% ----------
% Returns: 
% x_t - the output time-domain signal
%   1*T  array 
%  
% fs - Sampleing Rate 
%   int
%   
% t - time vector
%   1*T array 
%   
% -------

% employ the audioread function to read in the audio wav file
[y,fs]= audioread(filepath);

% only store the first channel of the signal (by taking the first column)
x_t = y(:,1);
x_t = x_t'; % is it necessary to transpose to a row vector?

% get the total length of the signal
length = size(y,1);

% set the time vector 
t = (1:length)/fs;



end

