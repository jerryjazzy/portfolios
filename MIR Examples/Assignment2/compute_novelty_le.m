function [n_t_le, t_le, fs_le] = compute_novelty_le(x_t, t, fs, win_size, hop_size)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% May 2015
% --------------------
% the function performs the Log Energy Derivative of an input signal
%--------------------
% Parameters: 
% x_t - the input time-domain signal
%   1*T array
% t - the input time vector
%   1*T array
% fs - sampling rate
%   int scalar
% win_size - window size
%   int
% hop_size - hop size
%   int
% ----------
% Returns: 
% n_t_le - the novelty function
%   1*L array/vector
%  
% fs_le - Sampleing Rate 
%   float, scalar
%   
% t_le - time vector in seconds
%   1*L vector/array
% --------------------
% Upgrades in this version:
% - Optimized the for-loop to greatly enhance the speed: 
%    1) moved out the window function calls inside and
%    2) minimized the calculation for local energy by using matrix
%    multiplications
% - Removed the normalization at the beginning since it unreasonably 
%   degrades the dynamics (the normalization only occurs in peak picking) 


% normalization <- deleted
% x_t = x_t/max(abs(x_t));

% pre-processing : pad N/2 zeros to both directions of the original signal
x_t_padded = padarray(x_t,[0,win_size/2]);
x_t_energy = x_t_padded.^2;
window = hamming(win_size);

% pre-allocate an array of energy to enhance the efficiency
numOfFrames = ceil(length(t)/hop_size);
energy = zeros(1,numOfFrames);

% calculate the local energy
for m = 1 : numOfFrames
    
    energy(m) = x_t_energy(1+(m-1)*hop_size : win_size+(m-1)*hop_size) * window;
    
end

% calculate the fs of the novelty function
fs_le = (fs/hop_size); 
% get the duration  of the signal
dur = length(t)/fs;
% derivation results in one point of time lost
t_le = 0:(1/fs_le): dur-1/fs_le;
% calculate the log energy derivative
n_t_le = diff(log10(energy+eps));

%Note: when using the log function, it is recommended to add "eps",
%the smallest floating point value in Matlab, to the argument, 
%to avoid numerical instability

end







