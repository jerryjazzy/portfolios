function [train_features, train_labels, a, b] = ...
create_train_set(fpath1, fpath2, fpath3, fpath4, params)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
%     Compute features and parameters for training data.
% 
% Parameters
% ----------
% fpath1: string
%     full path to audio file with training data from class 1
% fpath2: string
%     full path to audio file with training data from class 2
% fpath3: string
%     full path to audio file with training data from class 3
% fpath4: string
%     full path to audio file with training data from class 4
% params: struct
% Matlab structure with fields are win size, hop size,
% min freq, max freq, num mel filts, n dct, the parameters needed for computation of MFCCs
% 
% Returns
% -------
% train_features: NF x NE matrix
%     matrix of training set features 
%   (NF is number of features and NT is number of feature instances) 
% train_labels: 1 x NE array
%     vector of labels (class numbers) for each instance of train features
    
    
% field1 = 'win_size';  value1 = 1024;
% field2 = 'hop_size';  value2 = 512;
% field3 = 'min_freq';  value3 = 86 ;
% field4 = 'max_freq';  value4 = 8000 ;
% field5 = 'num_mel_filts';  value5 = 40 ;
% field6 = 'n_dct';  value6 = 15 ;
% 
% params = struct(field1,value1,field2,value2,field3,value3,field4,value4, ...
%         field5, value5, field6, value6);

%--------------
% For class #1
[mfccs, fs_mfcc] = compute_mfccs(fpath1, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);

features_temp = compute_features(mfccs, fs_mfcc);
[NF,NE] = size(features_temp);
features = zeros(NF,NE);
% features = zeros(NF,60);

% Randomly combine the feature vectors
index = 0;
for j = 1:15
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------
% For class #2
[mfccs, fs_mfcc] = compute_mfccs(fpath2, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);
features_temp = compute_features(mfccs, fs_mfcc);
index = 0;
for j = 16:30
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------
% For class #3
[mfccs, fs_mfcc] = compute_mfccs(fpath3, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);
features_temp = compute_features(mfccs, fs_mfcc);
index = 0;
for j = 31:45
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------
% For class #4
[mfccs, fs_mfcc] = compute_mfccs(fpath4, params.win_size, params.hop_size, ...
    params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);
features_temp = compute_features(mfccs, fs_mfcc);
index = 0;
for j = 46:60
    index = randi([1,4])+index;
    features(:,j) = features_temp(:,index);
end
%--------------


% output:
[train_features, a, b] = normalize_features(features);
train_labels = [ones(1,15),2*ones(1,15),3*ones(1,15), 4*ones(1,15)];

% NOTE: 
% I believe the order of the classes does not really matter in terms of training
% So here what I do is to only randomly pick 15 index of each class and 
% then mix them together -- that's why the labels are evenly distributed.


end