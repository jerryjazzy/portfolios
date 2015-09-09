function [test_features, test_labels] = ...
create_test_set(fpath1, fpath2, fpath3, fpath4, params, a, b)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
%     Compute features and parameters for test data.
%     
% Parameters
% ----------
% fpath1: string
%     full path to audio file with test data from class 1
% fpath2: string
%     full path to audio file with test data from class 2
% fpath3: string
%     full path to audio file with test data from class 3
% fpath4: string
%     full path to audio file with test data from class 4
% params: struct
%   struct storing the parameters
%   needed for computation of MFCCs.
%   The fields of the struct are: win size, hop size, min freq, max freq, num mel filts, n dct
% a: float
%     normalization parameter
% b: float
%     normalization parameter
%     
% Returns
%  -------
% test_features: NF x NE matrix
%   matrix of test set features (NF is number of features and NT is number of feature instances)
% test_labels: 1 x NE array
%   vector of labels (class numbers) for each instance of test features


% For class #1
[mfccs, fs_mfcc] = compute_mfccs(fpath1, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);
features_temp = compute_features(mfccs, fs_mfcc);
[NF,NE] = size(features_temp);
features = zeros(NF,NE);
% features = zeros(NF,20);


% Randomly combine the feature vectors
index = 0;
for j = 1:5
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------
% For class #2
[mfccs, fs_mfcc] = compute_mfccs(fpath2, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);
features_temp = compute_features(mfccs, fs_mfcc);
% Randomly combine the feature vectors
index = 0;
for j = 6:10
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------
% For class #3
[mfccs, fs_mfcc] = compute_mfccs(fpath3, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);
features_temp = compute_features(mfccs, fs_mfcc);
% Randomly combine the feature vectors
index = 0;
for j = 11:15
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------
% For class #4
[mfccs, fs_mfcc] = compute_mfccs(fpath4, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);
features_temp = compute_features(mfccs, fs_mfcc);
% Randomly combine the feature vectors
index = 0;
for j = 16:20
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------


% output:
% [test_features, ~, ~] = normalize_features(features, a, b);
[test_features, ~, ~] = normalize_features(features);

test_labels = [ones(1,5),2*ones(1,5),3*ones(1,5), 4*ones(1,5)];


end
