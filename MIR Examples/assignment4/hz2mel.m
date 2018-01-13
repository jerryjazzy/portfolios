function melval = hz2mel(hzval)
% Convert a vector of values in Hz to Mels.
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
%
% Parameters
% ----------
% hzval: 1xN array
%       values in Hz
%
% Returns
% -------
% melval:1xN array
%       values in Mels
%--------------------------------------

melval = 1127.01028 * log(1+hzval/700);

end
