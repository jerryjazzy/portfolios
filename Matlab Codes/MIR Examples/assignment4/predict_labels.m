function predicted_labels = ...
    predict_labels(train_features, train_labels, test_features)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
%     Predict the labels of the test features,
%     given training features and labels,
%     using a nearest-neighbor classifier.
% 
% Parameters
% ----------
% train_features: NF x NE train matrix
%     matrix of training set features (NF is number of
%     features and NE train is number of feature instances) 
% train_labels: 1 x NE train array
%     vector of labels (class numbers) for each instance
%     of train features
% test_features: NF x NE test matrix
%     matrix of test set features (NF is number of features and NE test 
%     is number of feature instances)
% 
% Returns
% -------
% predicted_labels: 1 x NE test array
%     array of predicted labels

[~, NE] = size(test_features);
predicted_labels = zeros(1,NE);

for i = 1:NE
   % compute the dot product
   tempMat =  test_features(:,i)' * train_features;
   % pick the maximum
   [~,idx] = max(tempMat);
   % record the corresponded label number
   predicted_labels(i) = train_labels(idx);
       
end

  
end