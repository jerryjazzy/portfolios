function c_smoothed = prefiltering(chromagram, win_size, type)
%   pre-filter the chromagram by using a moving median/average filter
% ---------
% Paramters:
% ---------
% chromagram: NF x NT array 
%   NF is no. of features (= 12) and NT is the frame-based time vector
% win_size: int 
%   no. of frames to be included within a window (e.g. = 15)
% type: string
%   'mean' or 'median' for the window type
% ---------
% Return:
% ---------
% c_smoothed: NF x NT array
%   the smoothed chromagram with the same size as the input
% t_c: 1 x NT array
%   the same with the time vector from the chromagram
% ---------

% pre-allocate
[NF, NT] = size(chromagram);
c_smoothed = zeros(NF,NT);

if strcmp(type,'mean')    
    % zero-pad for the smoothing
    c = padarray(chromagram,[0 floor(win_size/2)], 'both');
    % a direct way, but not sure if the efficiency is satisfying
    for n = 1:NT
        tempMat = c(:,n:n+win_size-1);
        c_smoothed(:,n) = mean(tempMat,2);   
        % an alternative: median filter
        %c_smoothed(:,n) = median(tempMat,2);    
    end    
elseif strcmp(type,'median')
   c_smoothed = medfilt1(chromagram,win_size, NT, 2);   
else 
    error('wrong input for the window type');
end

% NOTE: consider using matrix operations instead of loops
end