function y = evaluate(estimation, framed_chords)
% Suspended augmented and diminished chords are discarded from this
% evaluation task.  The 7th, min7, maj7, minmaj7, min6, maj6, 9, maj9, and
% min9 chords are merged to their root triads. Suspended augmented and
% diminished chords are discarded from this evaluation task.

y = 0;
for i = 1:length(framed_chords)
    if(strcmp(framed_chords(i), 'N') && estimation(i) == 0)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'C') && estimation(i) == 1)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'C#') || strcmp(framed_chords(i), 'Db')) && estimation(i) == 2)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'D') && estimation(i) == 3)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'D#') || strcmp(framed_chords(i), 'Eb')) && estimation(i) == 4)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'E') && estimation(i) == 5)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'F') && estimation(i) == 6)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'F#') || strcmp(framed_chords(i), 'Gb')) && estimation(i) == 7)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'G') && estimation(i) == 8)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'G#') || strcmp(framed_chords(i), 'Ab')) && estimation(i) == 9)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'A') && estimation(i) == 10)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'A#') || strcmp(framed_chords(i), 'Bb')) && estimation(i) == 11)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'B') && estimation(i) == 12)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'C:min') && estimation(i) == 13)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'C#:min') || strcmp(framed_chords(i), 'Db:min')) && estimation(i) == 14)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'D:min') && estimation(i) == 15)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'D#:min') || strcmp(framed_chords(i), 'Eb:min')) && estimation(i) == 16)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'E:min') && estimation(i) == 17)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'F:min') && estimation(i) == 18)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'F#:min') || strcmp(framed_chords(i), 'Gb:min')) && estimation(i) == 19)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'G:min') && estimation(i) == 20)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'G#:min') || strcmp(framed_chords(i), 'Ab:min')) && estimation(i) == 21)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'A:min') && estimation(i) == 22)
        y = y + 1;
        continue;
    elseif((strcmp(framed_chords(i), 'A#:min') || strcmp(framed_chords(i), 'Bb:min')) && estimation(i) == 23)
        y = y + 1;
        continue;
    elseif( strcmp(framed_chords(i), 'B:min') && estimation(i) == 24)
        y = y + 1;
        continue;
    end
end

y = y / length(framed_chords);

end