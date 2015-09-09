function [template_matrix, t_template] = template_matching(c_smoothed, t_chromagram)
%   Pattern matching using a binary template defined by hand
% ---------
% Paramters:
% ---------
% c_smoothed: NF x NT array
%   the smoothed chromagram
% t_c: 1 x NT array
%   the time vector of the chromagram
% ---------
% Return:
% ---------
% estimations: 1 x NT array
%   the indices of chords estimated (frame-based)
% tamplate_matrix: NC x NT array
%   a matrix after template matching, NC = no. of chord labels
% t_template: 1 x NT array
%   the same with the time vector from the chromagram

% define the intervals
root = 0;
min3rd = 3;
maj3rd = 4;
dim5th = 6;
per5th = 7;
aug5th = 8;
min7th = 10;
maj7th = 11;
% root = 0*3+1;
% min3rd = 3*3+1;
% maj3rd = 4*3 +1;
% dim5th = 6*3+1;
% per5th = 7*3+1;
% aug5th = 8*3+1;
% min7th = 10*3+1;
% maj7th = 11*3+1;
template = zeros(24,12); % 24 or much more

for key = 0:11
    R = mod(key+root,12)+1;
    m3 = mod(key+min3rd,12)+1; M3 = mod(key+maj3rd,12)+1;
    d5 = mod(key+dim5th,12)+1; p5 = mod(key+per5th,12)+1;a5 = mod(key+aug5th,12)+1;
    m7 = mod(key+min7th,12)+1; M7 = mod(key+maj7th,12)+1;
%     R = mod(key+root,36)+1;
%     m3 = mod(key+min3rd,36)+1; M3 = mod(key+maj3rd,36)+1;
%     d5 = mod(key+dim5th,36)+1; p5 = mod(key+per5th,36)+1;a5 = mod(key+aug5th,36)+1;
%     m7 = mod(key+min7th,36)+1; M7 = mod(key+maj7th,36)+1;
    template(key+1,[R, M3, p5]) = 1; % for all the major triads
    template(key+1+12,[R, m3, p5] ) = 1;% for all the minor triads
%     template(key+1+24, [R, m3, d5]) = 1; % for all the diminished triads
%     template(key+1+36, [R, M3, a5]) = 1; % for all the augmented triads
    % more...
end


template_matrix = template * c_smoothed;

% NORMALIZATION
[NF,NT] = size(template_matrix);
template_norm = zeros(NF, NT);
for i = 1:NT
    template_norm(:,i) = (template_matrix(:,i) - min(template_matrix(:,i))) ...
        / (max(template_matrix(:,i)) - min(template_matrix(:,i)));
end

template_matrix = template_norm;
% [~, estimations] = max(template_matrix);

t_template = t_chromagram;


end