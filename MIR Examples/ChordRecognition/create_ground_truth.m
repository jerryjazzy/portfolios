function framed_chords = create_ground_truth(timestamps, chords, t_template)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the ground truth chords extracted from .csv files
%
% timestamps : The onsets and offsets of each chord in the piece,
%             extracted from the .csv file
% chords     : The chords in the piece, extracted from the .csv file
% t_template : The time vector of the estimated chords matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Index for the chords and timestamps array
idx = 1;
framed_chords = cell(1, length(t_template));

for i = 1: length(t_template)
    % If the time frame is less than the current offset (indicated by idx)
    % Set the chord of the current time frame to the chord corresponding to that offset
    if(t_template(i) <= timestamps(2, idx))
        framed_chords(i) = chords(idx);
        
        % If the time frame is greater than the current offset (indicated by idx)
        % Set the chord of the current time frame to the chord corresponding to the next offset
        % Also increase the offset by 1
    else
        if (length(chords) > idx)
            idx = idx+1;
            framed_chords(i) = chords(idx);
        end
        
    end
end

end