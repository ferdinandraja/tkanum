function total_flops = calculate_flops_linear_regression_qr(X_std, y)
    % Number of data points (n) and number of features (m)
    [n, m] = size(X_std);
    
    % Step 1: FLOPs for QR decomposition (O(2nm^2 - 2/3m^3))
    flops_qr = 2 * n * m^2 - 2/3 * m^3;
    
    % Step 2: FLOPs for solving R * theta = Q' * y (O(m^2 n))
    flops_solve = 2 * m^2 * n;
    
    % Total FLOPs for Linear Regression (QR Decomposition)
    total_flops = flops_qr + flops_solve;
    fprintf('FLOPs for Linear Regression (QR Decomposition): %.2f\n', total_flops);
end