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

% convert into mono by taking the mean of the two channels if it's stereo
x_t = mean(y,2);
x_t = x_t'; 

% get the total length of the signal
length = size(y,1);

% set the time vector 
t = (0:length-1)/fs;



end

