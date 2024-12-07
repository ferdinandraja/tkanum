function total_flops = calculate_flops_pca_qr(X_std)
    % Number of data points (n) and number of features (m)
    [n, m] = size(X_std);
    
    % Step 1: FLOPs for covariance matrix (X_std' * X_std) => O(m^2 n)
    flops_covariance = 2 * m^2 * n;
    
    % Step 2: FLOPs for QR decomposition => O(2nm^2 - 2/3m^3)
    flops_qr = 2 * n * m^2 - 2/3 * m^3;
    
    % Total FLOPs for PCA (QR Decomposition)
    total_flops = flops_covariance + flops_qr;
    fprintf('FLOPs for PCA using QR Decomposition: %.2f\n', total_flops);
end