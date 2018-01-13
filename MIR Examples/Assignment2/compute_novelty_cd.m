function [n_t_cd, t_cd, fs_cd] = compute_novelty_cd(x_t, t, fs, win_size, hop_size)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% May 2015
% --------------------
% Compute Complex Domain function
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
% n_t_cd - the novelty function
%   1*L array/vector
%  
% fs_cd - Sampleing Rate 
%   float, scalar
%   
% t_cd - time vector in seconds
%   1*L vector/array
% --------------------
% Upgrades in this version:
% - Slight optimizations in the for loop.
% - Replaced the phase function with the angle function.
% - Removed the normalization at the beginning since it unreasonably 
%   degrades the dynamics (the normalization only occurs in peak picking) 


% normalization
% x_t = x_t/max(abs(x_t));


% First employ the spectrogram function to obtain the required information
noverlap = win_size - hop_size;
[S,F,T] = spectrogram(x_t,win_size,noverlap,win_size,fs);

% no. of frames
numOfFrames = length(T);

% pre-allocation
n_t_cd = zeros(1,numOfFrames);
H_x = zeros(1,length(F));

% do math!
for m = 3 : numOfFrames
    for k = 1:length(F)   
        
        % perform the half-wave rectification function
        if abs(S(k,(m)))>= abs(S(k,m-1))
        phase_m = princarg(2*angle(S(k,m-1)) - angle(S(k,m-2)));
        S_hat_k_m = abs(S(k,m-1))*exp(1i*phase_m);    
        H_x(k) = abs(S(k,m) - S_hat_k_m);
        else
        H_x(k) = 0;
        end
        
    end        
    
    % calculate the mean value
    n_t_cd(m-2) = (2/win_size) * sum(H_x);
end

% calculate the fs of the novelty function
fs_cd = (fs/hop_size);
% the t_sf vectors is identical to the T vectors from spectrogram
t_cd = T;




end



function phase_out=princarg(phase_in)
% princarg, function to compute the principal phase argument in the range [-pi, pi].

phase_out=mod(phase_in+pi,-2*pi)+pi;

end

