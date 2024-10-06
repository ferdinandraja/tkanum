function [Z, eigenvalues, eigenvectors] = pca_eigen(X_std,Sigma, k)
    [k, eigenvalues, eigenvectors] = calculate_optimal_k_eigen(Sigma, 0.90)
    
    % Step 4: Select the top k eigenvectors (principal components)
    V_k = eigenvectors(:, 1:k);  % Select the first k eigenvectors
    
    % Step 5: Transform the original data into the principal component space
    Z = X_std * V_k;
end
