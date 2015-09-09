function [F, P, R] = evaluate_onsets(ref_onsets, est_onsets, tolerance)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% March 2015
% --------------------
% Compute precision, recall, and f-measure for a pair of onsets.
%
% Parameters
% ----------
% ref_onsets : 1 x P1 array
%       array of reference (ground truth) onset times in seconds
% est_onsets : 1 x P2 array
%       array of estimated onset times in seconds
% tolerance : float
%       onset accuracy threshold (seconds)
%
% Returns
% -------
% F : float
%       F-measure
% P : float
%       precision
% R : float
%       recall (true positive)


L = length(ref_onsets);
M = length(est_onsets);
c = 0;

% Since the length of onsets is not normally too long, I kept the for loops
% here.
for i = 1:L
    for j = 1:M
        if((abs(ref_onsets(i)-est_onsets(j))<tolerance)&&(est_onsets(j)~=0))
            c = c + 1;
         % ?  ref_onsets(i) = 0;
            est_onsets(j) = 0;
            break
        end
    end
end

% f+ and f-
f_pos = length(est_onsets)-c;
f_neg = length(ref_onsets)-c;

% calculate the benchmarkings
P = c/(c+f_pos);
R = c/(c+f_neg);
F = 2*P*R/(P+R);
end