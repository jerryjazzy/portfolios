function [path_hat] = viterbi(transMat,emisMat)
% perform the Viterbi algorithm to find the most likely sequence of states
% given a sequence of observations.
% ---------
% Parameters:
% ---------
% obs: array
%   numOfChords x numOfFrames observations
% transMat: array 
%   numOfChords x numOfChords transition matrix
% emisMat: array
%   numOfChords x numOfFrames emission matrix
% ---------
% Returns:
% ---------
% currentState:
% logP:

[numOfChords, numOfFrames] = size(emisMat);
initialMat = ones(numOfChords,1)/numOfChords;
for i = 1: numOfFrames
   if  (isnan(emisMat(1,i)) == 0)
       columnIdx = i;
        break
   end
end


% for efficiency calculate the log matrix at first
tr_log = log(transMat);
e_log = log(emisMat);

% construct the V matrix
v = zeros(numOfChords, numOfFrames);
v(:,columnIdx) = e_log(:,columnIdx) + log(initialMat);
path = zeros(numOfChords, numOfFrames);
v_max = zeros(1,numOfChords);
for t = columnIdx+1: numOfFrames
    for j = 1:numOfChords
        
        for i = 1:numOfChords
            v_max(i) = v(i,t-1) + tr_log(i,j) + e_log(j,t);
        
        end
        [v(j,t),chord_idx] = max(v_max);
        path(j, t-1) = chord_idx;
    end
    
end

path(: , end) = (1:numOfChords);
path(:,1:columnIdx) = 0;

[~, idx] = max(v(:,end));

path_hat = path(idx,:);
 

end