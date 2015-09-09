function training_set = build_training_data(directory, chord_idx)

training_set = [];
cd(directory);

x = dir(); cd ..;
for i = 3:length(x) 
    y = x(i).name;
    xx = dir([directory '/' y '/*.mp3']);
    xxx = dir([directory '/' y '/*.lab']);
    for j = 1:length(xx)
        yy = xx(j).name; yyy = xxx(j).name;  
        mp3_file = [directory '/' y '/' yy];
        lab_file = [directory '/' y '/' yyy]; 
        % Chord recognition algorithm
        [chromagram, t_chromagram] = compute_chromagram(mp3_file, 8192, 4096, 12, 4, 64.5);
        chromagram = prefiltering(chromagram, 15, 'median');
        
        % Frame-based annotation creation
        [chords,timestamps] = labread(lab_file);
        framed_chords = create_ground_truth(timestamps, chords, t_chromagram);
        framed_chords_int = ground_truth_int(framed_chords);
        
        for k = 1:size(framed_chords_int,2)
            if(framed_chords_int(k) == chord_idx)
                training_set = [training_set chromagram(:,k)];
            end
        end
                
    end
end
end