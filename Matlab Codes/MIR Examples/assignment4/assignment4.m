% Assignment #4 Script
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------

%% Q1
field1 = 'win_size';  value1 = 1024;
field2 = 'hop_size';  value2 = 512;
field3 = 'min_freq';  value3 = 86 ;
field4 = 'max_freq';  value4 = 8000 ;
field5 = 'num_mel_filts';  value5 = 40 ;
field6 = 'n_dct';  value6 = 15 ;

params = struct(field1,value1,field2,value2,field3,value3,field4,value4, ...
        field5, value5, field6, value6);
    
fpath1 = 'files/eguitar_train.wav';
fpath2 = 'files/piano_train.wav';
fpath3 = 'files/synth_train.wav';
fpath4 = 'files/trumpet_train.wav';
tic;
[train_features, train_labels, a, b] = ...
create_train_set(fpath1, fpath2, fpath3, fpath4, params);
toc;

%% Q2
fpath1 = 'files/eguitar_test.wav';
fpath2 = 'files/piano_test.wav';
fpath3 = 'files/synth_test.wav';
fpath4 = 'files/trumpet_test.wav';
tic;
[test_features, test_labels] = ...
create_test_set(fpath1, fpath2, fpath3, fpath4, params, a, b);
toc;

%% Q3
 predicted_labels = ...
    predict_labels(train_features, train_labels, test_features)
[overall_accuracy, per_class_accuracy] = ...
    score_prediction(test_labels, predicted_labels)

%% Q5
fpath1 = 'files/eguitar_train.wav';
fpath2 = 'files/piano_train.wav';
fpath3 = 'files/trombone_train.wav';
fpath4 = 'files/trumpet_train.wav';
[train_features, train_labels, a, b] = ...
create_train_set(fpath1, fpath2, fpath3, fpath4, params);

fpath1 = 'files/eguitar_test.wav';
fpath2 = 'files/piano_test.wav';
fpath3 = 'files/trombone_test.wav';
fpath4 = 'files/trumpet_test.wav';

[test_features, test_labels] = ...
create_test_set(fpath1, fpath2, fpath3, fpath4, params, a, b);

predicted_labels = ...
    predict_labels(train_features, train_labels, test_features)
[overall_accuracy, per_class_accuracy] = ...
    score_prediction(test_labels, predicted_labels)
