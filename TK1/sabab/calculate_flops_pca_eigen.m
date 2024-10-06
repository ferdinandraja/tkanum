function total_flops = calculate_flops_pca_eigen(X_std)
    % Number of data points (n) and number of features (m)
    [n, m] = size(X_std);
    
    % Step 1: FLOPs for covariance matrix (X_std' * X_std) => O(m^2 n)
    flops_covariance = 2 * m^2 * n;
    
    % Step 2: FLOPs for eigenvalue decomposition => O(m^3)
    flops_eigen = 10/3 * m^3;
    
    % Total FLOPs for PCA (Eigenvalue Decomposition)
    total_flops = flops_covariance + flops_eigen;
    fprintf('FLOPs for PCA using Eigenvalue Decomposition: %.2f\n', total_flops);
end