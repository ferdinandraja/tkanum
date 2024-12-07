function Sigma = covariance(X)
    [m, ~] = size(X); % m is the number of rows
    Sigma = (X' * X) / (m - 1); % Normalized covariance matrix
end