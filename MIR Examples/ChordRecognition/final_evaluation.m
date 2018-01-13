function [ev_data, ev_cof, ev_comb, ev_BT] =...
    final_evaluation(directory, fs, win_size, hop_size, transition_matrix_data)

total = 0; ev_data = 0; ev_cof = 0; ev_comb = 0;ev_BT=0;
% transition_matrix_data = final_transition(directory, fs, win_size, hop_size);
transition_matrix_cof  = tr_cof();
transition_matrix_comb = (transition_matrix_data + transition_matrix_cof*5)/6;
cd(directory);

x = dir(); cd ..;
for i = 3:length(x) 
    y = x(i).name;
    xx  = dir([directory '/' y '/*.lab']);
    xxx = dir([directory '/' y '/*.mp3']);
    total = total + length(xx);
    for j = 1:length(xx)
        yy  = xx(j).name;   lab_file = [directory '/' y '/' yy];
        yyy = xxx(j).name;  mp3_file = [directory '/' y '/' yyy];
            
        % Chord recognition algorithm
        [chromagram, t_chromagram] = compute_chromagram(mp3_file, win_size, hop_size, 12, 3, 65.4);
        c_smoothed = prefiltering(chromagram, 15, 'median');
        [template_matrix, t_template] = template_matching(c_smoothed, t_chromagram);
        
%         estimation_data = viterbi(transition_matrix_data,template_matrix);
%         estimation_cof  = viterbi(transition_matrix_cof, template_matrix);
        estimation_comb = viterbi(transition_matrix_comb,template_matrix);
        
%         template_matrix = prefiltering(template_matrix, 15, 'median');
%         [~, estimation_BT] = max(template_matrix);
        
        % Frame-based annotation creation
        [chords,timestamps] = labread(lab_file);
        framed_chords = create_ground_truth(timestamps, chords, t_template);
        
        % Evaluate for different transition matrices
%         ev_data = ev_data + evaluate(estimation_data, framed_chords);
%         ev_cof  = ev_cof  + evaluate(estimation_cof,  framed_chords);
        ev_comb = ev_comb + evaluate(estimation_comb, framed_chords);
%         ev_BT = ev_BT + evaluate(estimation_BT, framed_chords);
        
    end
end

ev_data = ev_data/total; ev_cof = ev_cof/total; ev_comb = ev_comb/total;
ev_BT = ev_BT/total;

display(ev_data);
display(ev_cof);
display(ev_comb);
display(ev_BT);


end