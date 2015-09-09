function [overall_accuracy, per_class_accuracy] = ...
    score_prediction(test_labels, predicted_labels)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
%   Compute the confusion matrix given the test labels and predicted labels.
%
% Parameters
% ----------
% test labels: 1 x NE array
%       array of ground truth labels for test data
% predicted labels: 1 x NE test
%       array of predicted labels
%
% Returns
% -------
% overall accuracy: scalar
%       The fraction of correctly classified examples.
% per class accuracy: 1 x 4 array
%       The fraction of correctly classified examples for each instrument class.
%       
%       per class accuracy[1] should give the value for
%       instrument class 1, per class accuracy[2] for
%       instrument class 2, etc.

% get the difference of the two vectors
difference = test_labels - predicted_labels;
% non-zero elements correspond to wrong predictions
I = find(difference);

% the overall accuracy is (1- the fraction of errors)
overall_accuracy = 1 - length(I)/length(predicted_labels);


% per-class accuracy
per_class_accuracy = zeros(1,4);

test_labels1 = find(test_labels == 1);
predicted_labels1 = find(predicted_labels == 1);
matched_labels1 = intersect(test_labels1,predicted_labels1);
per_class_accuracy(1) = length(matched_labels1)/length(test_labels1);

test_labels2 = find(test_labels == 2);
predicted_labels2 = find(predicted_labels == 2);
matched_labels2 = intersect(test_labels2,predicted_labels2);
per_class_accuracy(2) = length(matched_labels2)/length(test_labels2);

test_labels3 = find(test_labels == 3);
predicted_labels3 = find(predicted_labels == 3);
matched_labels3 = intersect(test_labels3,predicted_labels3);
per_class_accuracy(3) = length(matched_labels3)/length(test_labels3);

test_labels4 = find(test_labels == 4);
predicted_labels4 = find(predicted_labels == 4);
matched_labels4 = intersect(test_labels4,predicted_labels4);
per_class_accuracy(4) = length(matched_labels4)/length(test_labels4);

end