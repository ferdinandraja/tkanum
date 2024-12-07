function total_flops = calculate_flops_linear_regression_normal(X_std, y)
    % Number of data points (n) and number of features (m)
    [n, m] = size(X_std);
    
    % Step 1: FLOPs for X' * X (O(m^2 n))
    flops_xtx = 2 * m^2 * n;
    
    % Step 2: FLOPs for matrix inversion (O(m^3))
    flops_inv = 2 * m^3;
    
    % Step 3: FLOPs for (X' * y) (O(mn))
    flops_xty = 2 * m * n;
    
    % Total FLOPs for Linear Regression (Normal Equation)
    total_flops = flops_xtx + flops_inv + flops_xty;
    fprintf('FLOPs for Linear Regression (Normal Equation): %.2f\n', total_flops);
end