function features = compute_features(mfccs, fs_mfcc)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
%  Compute features from MFCCs.
% Parameters
% ----------
% mfccs : n_dct x NT matrix
%   MFCC matrix 
% fs_mfcc : int
%     sample rate of MFCC matrix (samples/sec)
%     
% Returns
%  -------
% features: NF X NE matrix of segmented and averaged MFCCs 
%    (NF is number of features = n_dct-1 and NE is number of examples)
 

% Remove the first MFCC coefficient.
mfccs(1,:)=[];


numOfFeatures = size(mfccs,1);
numOfExamples = floor(size(mfccs,2) / fs_mfcc);


% Break the MFCC sequence into 1 second-long, non-overlapping subsequences, 
% and Compute the average MFCC vector for each subsequence.
features = zeros(numOfFeatures, numOfExamples);
% mfccs_padded = padarray(mfccs, fs_mfcc/2, 'pre');
for i = 1:numOfExamples
    segment = mfccs(:,(i-1)*fs_mfcc+1 : i*fs_mfcc);
    features(:,i) = mean(segment,2);
end
% segment = mfccs(:,(numOfExamples-1)*fs_mfcc+1 : end);
% features(:,numOfExamples) = mean(segment,2);

end