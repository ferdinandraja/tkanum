function [Z, eigenvalues] = pca_householder_no_Q(X_std, Sigma)
    [k, eigenvalues, R] = calculate_optimal_k(Sigma, 0.90)
    
    % Step 4: Approximate the principal components
    Z = X_std * R(:, 1:k); % Note that we don’t use eigenvectors here
end
