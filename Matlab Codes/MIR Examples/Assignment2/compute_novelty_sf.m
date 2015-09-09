function [n_t_sf, t_sf, fs_sf] = compute_novelty_sf(x_t, t, fs, win_size, hop_size)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% May 2015
% --------------------
% Compute Spectral Flux novelty function
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
% n_t_sf - the novelty function
%   1*L array/vector
%  
% fs_sf - Sampleing Rate 
%   float, scalar
%   
% t_le - time vector in seconds
%   1*L vector/array
% --------------------
% Upgrades in this version:
% 1) Replaced the for-loop with a few lines of matrix operations, which
%   greatly improves the efficiency.
% 2) Removed the normalization at the beginning since it unreasonably 
%   degrades the dynamics (the normalization only occurs in peak picking) 


% normalization - REMOVED
% x_t = x_t/max(abs(x_t));


% First employ the spectrogram function to obtain the required information
noverlap = win_size - hop_size;
[S,~,T] = spectrogram(x_t,win_size,noverlap,win_size,fs);

% difference matrix
diffMat = diff(abs(S),1,2) ;      
% Half-wave rectification
H_x = (diffMat+abs(diffMat))/2;
% obtain the SF function
n_t_sf = sum(H_x,1)*2/win_size;

% ----
% The following is optimized using a few lines above
% % do math!
% for m = 1 : numOfFrames-1
%     
%     for k = 1:length(F)        
%         H_x(k) = abs(S(k,(m+1)))-abs(S(k,m));                
%     end    
%     
%     % perform the half-wave rectification function
%     H_x = (H_x+abs(H_x))/2;
%     % calculate the mean value
%     n_t_sf(m) = (2/win_size) * sum(H_x);
%     
% end
% ----


% calculate the fs of the novelty function
fs_sf = (fs/hop_size);
% the t_sf vectors is identical to the T vectors from spectrogram
t_sf = T(1:end-1);

end
