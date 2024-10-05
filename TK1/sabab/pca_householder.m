function [Z, eigenvalues, eigenvectors] = pca_householder(X_std, Sigma, k)
    [k, eigenvalues, eigenvectors] = calculate_optimal_k(Sigma, 0.90);
    
    % Step 3: Select top k components
    V_k = eigenvectors(:, 1:k);
    
    % Step 4: Transform data into principal components
    Z = X_std * V_k;
end