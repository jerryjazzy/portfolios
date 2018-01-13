function [chords,timestamps] = labread(filename)
%   Read in the .lab file and convert it to a chord array and a timestamps array
% Parameter:    
% ---------
% filename: string
%     the filepath
%
% Returns:
% ---------
% chords: 1 x N array
%   an array of labeled chords.
% timestamps: 2 x N array
%   an array of onsets and offsets


[onset, offset, chords] = textread(filename,'%f %f %s');

chords = char(chords');
timestamps = [onset';
              offset'];
          
[~, cols] = size(chords);
for i = 1:length(chords)
    a = find(chords(i, :) == '/', 1);
    if(isempty(a) == 0)
        chords(i,a:end) = ' ';
    end
    a = find(chords(i, :)== '(', 1);
    chords(i,a:end) = ' ';
    a = find(chords(i, :)== ':', 1);
    if(isempty(a) == 0 && strcmp(chords(i,a+1),' '))
        chords(i,a:end) = ' ';
    elseif( isempty(a) == 0 && (strcmp(chords(i,a+1),'(') || ...
            strcmp(chords(i,a+1:end), ['maj7' blanks(cols-(4+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['aug'  blanks(cols-(3+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['sus4' blanks(cols-(4+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['maj'  blanks(cols-(3+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1),'7') || strcmp(chords(i,a+1),'9')))
        chords(i,a:end) = ' ';
    elseif( strcmp(chords(i,a+1:end), ['min7'    blanks(cols-(4+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['min6'    blanks(cols-(4+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['min9'    blanks(cols-(4+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['minmaj7' blanks(cols-(7+length(chords(i,1:a))))]))
        chords(i,a+4:end) = ' ';
    elseif( strcmp(chords(i,a+1:end), ['dim7'  blanks(cols-(4+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['hdim7' blanks(cols-(5+length(chords(i,1:a))))]) || ...
            strcmp(chords(i,a+1:end), ['dim'   blanks(cols-(3+length(chords(i,1:a))))]))
        chords(i,a+1:end) = ['min' blanks(cols-(3+length(chords(i,1:a))))];
    end
end

chords = (cellstr(chords))';
end