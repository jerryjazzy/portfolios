function hzval = mel2hz(melval)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
% Convert a vector of values in Hz to Mels.
%
% Parameters
% ----------
%   melval : 1 x N array
%       values in Mels
%
% Returns
% -------
% hzval:1xNarray
% values in Hz

    hzval = 700*(exp(melval/1127.01028)-1);

end