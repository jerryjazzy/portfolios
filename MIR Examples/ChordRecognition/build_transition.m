function transition_matrix = build_transition(chords)

idx = 0; flag5 = 0; flag2 = 0;
chords = char(chords);
transition_matrix = zeros(24);

for i = 1 : length(chords(:,1))
    if(strcmp(chords(i,1),'N'))
        if(idx == 0)
            idx = i;
        else
            idx = [idx i];
        end
    end
end

if(idx ~= 0)
   chords(idx, :) = []; 
end
if(length(chords(1,:)) < 5)
    flag5 = 1;
end
if(length(chords(1,:)) < 2)
    flag2 = 1;
end
chords_int = zeros(1, length(chords(:,1)));
for i = 1 : length(chords_int)
    if(flag5 == 0)
        if(strcmp(chords(i,1:5), 'C:min'))
            chords_int(i) = 13;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif((strcmp(chords(i,1:5), 'C#:mi') || strcmp(chords(i,1:5), 'Db:mi')))
            chords_int(i) = 14;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif(strcmp(chords(i,1:5),  'D:min'))
            chords_int(i) = 15;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif((strcmp(chords(i,1:5), 'D#:mi') || strcmp(chords(i,1:5), 'Eb:mi')))
            chords_int(i) = 16;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif(strcmp(chords(i,1:5),  'E:min'))
            chords_int(i) = 17;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif(strcmp(chords(i,1:5),  'F:min'))
            chords_int(i) = 18;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif((strcmp(chords(i,1:5), 'F#:mi') || strcmp(chords(i,1:5), 'Gb:mi')))
            chords_int(i) = 19;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif(strcmp(chords(i,1:5),  'G:min' ))
            chords_int(i) = 20;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif((strcmp(chords(i,1:5), 'G#:mi') || strcmp(chords(i,1:5), 'Ab:mi')))
            chords_int(i) = 21;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif(strcmp(chords(i,1:5),  'A:min'))
            chords_int(i) = 22;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif((strcmp(chords(i,1:5), 'A#:mi') || strcmp(chords(i,1:5), 'Bb:mi')))
            chords_int(i) = 23;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        elseif(strcmp(chords(i,1:5),  'B:min'))
            chords_int(i) = 24;
            if(i > 1)
                transition_matrix(chords_int(i-1),chords_int(i)) = ...
                    transition_matrix(chords_int(i-1),chords_int(i)) + 1;
                continue;
            end
        end
    end
    if(strcmp(chords(i,1), 'C'))
        chords_int(i) = 1;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(flag2 == 0 && (strcmp(chords(i,1:2), 'C#') || strcmp(chords(i,1:2), 'Db')))
        chords_int(i) = 2;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(strcmp(chords(i,1), 'D'))
        chords_int(i) = 3;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(flag2 == 0 && (strcmp(chords(i,1:2), 'D#') || strcmp(chords(i,1:2), 'Eb')))
        chords_int(i) = 4;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(strcmp(chords(i,1), 'E'))
        chords_int(i) = 5;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(strcmp(chords(i,1), 'F'))
        chords_int(i) = 6;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(flag2 == 0 && (strcmp(chords(i,1:2), 'F#') || strcmp(chords(i,1:2), 'Gb')))
        chords_int(i) = 7;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(strcmp(chords(i,1), 'G'))
        chords_int(i) = 8;
        if(i > 1)   
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(flag2 == 0 && (strcmp(chords(i,1:2), 'G#') || strcmp(chords(i,1:2), 'Ab')))
        chords_int(i) = 9;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(strcmp(chords(i,1), 'A'))
        chords_int(i) = 10;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(flag2 == 0 && (strcmp(chords(i,1:2), 'A#') || strcmp(chords(i,1:2), 'Bb')))
        chords_int(i) = 11;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    elseif(strcmp(chords(i,1), 'B'))
        chords_int(i) = 12;
        if(i > 1)
            transition_matrix(chords_int(i-1),chords_int(i)) = ...
                transition_matrix(chords_int(i-1),chords_int(i)) + 1;
            continue;
        end
    end
end
end