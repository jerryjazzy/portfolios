function framed_chords_int = ground_truth_int(framed_chords)

framed_chords_int = zeros(1,length(framed_chords));
for i = 1:length(framed_chords)
    if(strcmp(framed_chords(i), 'N'))
        framed_chords_int(i) = 0;
        continue;
    elseif( strcmp(framed_chords(i), 'C'))
        framed_chords_int(i) = 1;
        continue;
    elseif((strcmp(framed_chords(i), 'C#') || strcmp(framed_chords(i), 'Db')))
        framed_chords_int(i) = 2;
        continue;
    elseif( strcmp(framed_chords(i), 'D'))
        framed_chords_int(i) = 3;
        continue;
    elseif((strcmp(framed_chords(i), 'D#') || strcmp(framed_chords(i), 'Eb')))
        framed_chords_int(i) = 4;
        continue;
    elseif( strcmp(framed_chords(i), 'E'))
        framed_chords_int(i) = 5;
        continue;
    elseif( strcmp(framed_chords(i), 'F'))
        framed_chords_int(i) = 6;
        continue;
    elseif((strcmp(framed_chords(i), 'F#') || strcmp(framed_chords(i), 'Gb')))
        framed_chords_int(i) = 7;
        continue;
    elseif( strcmp(framed_chords(i), 'G'))
        framed_chords_int(i) = 8;
        continue;
    elseif((strcmp(framed_chords(i), 'G#') || strcmp(framed_chords(i), 'Ab')))
        framed_chords_int(i) = 9;
        continue;
    elseif( strcmp(framed_chords(i), 'A'))
        framed_chords_int(i) = 10;
        continue;
    elseif((strcmp(framed_chords(i), 'A#') || strcmp(framed_chords(i), 'Bb')))
        framed_chords_int(i) = 11;
        continue;
    elseif( strcmp(framed_chords(i), 'B'))
        framed_chords_int(i) = 12;
        continue;
    elseif( strcmp(framed_chords(i), 'C:min'))
        framed_chords_int(i) = 13;
        continue;
    elseif((strcmp(framed_chords(i), 'C#:min') || strcmp(framed_chords(i), 'Db:min')))
        framed_chords_int(i) = 14;
        continue;
    elseif( strcmp(framed_chords(i), 'D:min'))
        framed_chords_int(i) = 15;
        continue;
    elseif((strcmp(framed_chords(i), 'D#:min') || strcmp(framed_chords(i), 'Eb:min')))
        framed_chords_int(i) = 16;
        continue;
    elseif( strcmp(framed_chords(i), 'E:min'))
        framed_chords_int(i) = 17;
        continue;
    elseif( strcmp(framed_chords(i), 'F:min'))
        framed_chords_int(i) = 18;
        continue;
    elseif((strcmp(framed_chords(i), 'F#:min') || strcmp(framed_chords(i), 'Gb:min')))
        framed_chords_int(i) = 19;
        continue;
    elseif( strcmp(framed_chords(i), 'G:min'))
        framed_chords_int(i) = 20;
        continue;
    elseif((strcmp(framed_chords(i), 'G#:min') || strcmp(framed_chords(i), 'Ab:min')))
        framed_chords_int(i) = 21;
        continue;
    elseif( strcmp(framed_chords(i), 'A:min'))
        framed_chords_int(i) = 22;
        continue;
    elseif((strcmp(framed_chords(i), 'A#:min') || strcmp(framed_chords(i), 'Bb:min')))
        framed_chords_int(i) = 23;
        continue;
    elseif( strcmp(framed_chords(i), 'B:min'))
        framed_chords_int(i) = 24;
        continue;
    end
end

end