function [X_std, mu, sigma] = standardize(X)
    mu = mean(X);
    sigma = std(X);
    X_std = (X - mu) ./ sigma;
end