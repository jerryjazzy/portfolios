function [features_norm, a, b] = normalize_features(features, a, b)
% --------------------
% by Xiao (Jerry) Lu 
% N18993923
% Apr 2015
% --------------------
% Normalize matrix of features.
% Parameters
% ----------
% features: NF x NE matrix
%     matrix of features (NF is number of
% features and NE is number of examples) 
% a: NFx1 array
%     normalization parameter (optional)
% b: NFx1 array
%     normalization parameter (optional)
%     
% Returns
%  -------
% features_norm: NF x NE matrix
%     matrix of normalized features (NF is number of features and NT is number of examples)
% a:NFx1 array 
%     normalization parameter
% b:NFx1 array 
%     normalization parameter

if nargin<3 
    a = min(features,[],2);
    b = max(features,[],2) - a;
end
[NF,NE] = size(features);

% a_temp = repmat(a, 1, NE);
% b_temp = repmat(b, 1, NE);
% 
% 
% features_norm = (features - a_temp) ./ b_temp ; 
%

% An alternative way:
% Normalizing the feature matrix across coefficients (columns) 
% - dividing each column by its L2 norm 
features_norm = zeros(NF, NE);
for i = 1:NE
    features_norm(:,i) = features(:,i)/norm(features(:,i));
end


end
