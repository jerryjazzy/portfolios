filepath = 'The Beatles/01_-_Please_Please_Me/08_-_Love_Me_Do.mp3';
win_size = 4096*2;
hop_size = 4096;
b_p_o = 12;
n_octaves = 4;
f_min = 65.4 ; % low C
[chords, timestamps] = labread('The Beatles/01_-_Please_Please_Me/08_-_Love_Me_Do.lab');

[chromagram, t_chromagram] = compute_chromagram(filepath, win_size, hop_size, ...
    b_p_o, n_octaves, f_min);

win_size_smooth = 15;
type = 'median';
c_smoothed = prefiltering(chromagram, win_size_smooth, type);

[template_matrix, t_template] = template_matching(chromagram, t_chromagram);
framed_chords = create_ground_truth(timestamps, chords, t_template);
template_matrix_2 = prefiltering(template_matrix, win_size_smooth, type);

figure;
chordLabels = plot_chords(template_matrix, t_template);
accuracy_BT = evaluate(chordLabels, framed_chords);
display(accuracy_BT);
% 
% final_tr = final_transition('The Beatles',44100, 8192, 4096);
% final_tr_cof = tr_cof();
% transMat = (final_tr*1 + final_tr_cof*4 )/5;
% path = viterbi(transMat, template_matrix);
% hold on;
% plot(path, 'ro');
% accuracy_viterbi = evaluate(path, framed_chords);
% display(accuracy_viterbi);

framed_chords_int = ground_truth_int(framed_chords);
plot(framed_chords_int, 'go');

xlabel('time(s)');
ylabel('estimated chords');

            
hold off;
