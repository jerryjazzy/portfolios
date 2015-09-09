function final_tr = final_transition(directory,fs,win_size,hop_size)

final_tr = zeros(24);
cd(directory);

x = dir(); cd ..;
for i = 3:length(x) 
    y = x(i).name;
    xx = dir([directory '/' y '/*.lab']);
    for j = 1:length(xx)
        yy = xx(j).name;
        frame_size = (win_size-hop_size)/fs;
        t_template = frame_size;
         [chords,timestamps] = labread([directory '/' y '/' yy]);
        while(t_template(end)+frame_size<timestamps(2,end))
            t_template = [t_template t_template(end)+frame_size];
        end
        framed_chords = create_ground_truth(timestamps, chords, t_template);
        final_tr = final_tr + build_transition(framed_chords);
    end
end

for i = 1:length(final_tr(:,1))
    final_tr(i,:) = final_tr(i,:)/sum(final_tr(i,:));
end
end