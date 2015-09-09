function emission_vector = gmm_emission(chromagram, params)

weights = params.alpha;
means   = params.m;
covars  = params.W;
dim     = size(means, 1);
emission_vector = zeros(1, size(chromagram, 2));

for t = 1:size(chromagram,2)
    p = 0;
    for k = 1:length(weights)
        n = (1/((2*pi)^(dim/2))*(det(covars(:,:,k))^(1/2)))*...
            exp(-1/2*(chromagram(:,t)-means(:,k))'*(inv(covars(:,:,k)))*(chromagram(:,t)-means(:,k)));
        p = p + weights(k) * n;
    end
    emission_vector(t) = p;
end