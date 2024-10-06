data = csvread('pokindex_data.csv');
X = data(:, 1:end-1); % Features
y = data(:, end);     % Response variable

% Step 1: Standardize the data
[X_std, mu, sigma] = standardize(X);

% Step 2: Compute covariance matrix
Sigma = covariance(X_std);

% Step 3: Perform PCA using QR decomposition (Householder with stored Q) 

% Step 4: Linear regression using the three approaches

% Measure time for Normal Equation
tic;
[Z_normal, eigenvalues_normal, eigenvectors_normal] = pca_eigen(X_std,Sigma);
theta_normal = linear_regression_normal(Z_normal, y);
time_normal = toc;

% Measure time for QR Decomposition without Q
tic;
[Z_no_Q, eigenvalues_no_Q] = pca_householder_no_Q(X_std,Sigma); 
theta_qr = linear_regression_qr(Z_no_Q, y);
time_qr = toc;

% Measure time for QR Decomposition with stored Q
tic;
[Z, eigenvalues, eigenvectors] = pca_householder(X_std, Sigma);  
theta_qr_stored_Q = linear_regression_qr_with_Q(Z, y);
time_qr_stored_Q = toc;

fprintf('Time (Normal Equation): %.5f seconds\n', time_normal);
fprintf('Time (QR Decomposition): %.5f seconds\n', time_qr);
fprintf('Time (QR with stored Q): %.5f seconds\n', time_qr_stored_Q);
% Step 5: Compute residuals for comparison
residual_normal = compute_residuals(Z_normal, y, theta_normal);
residual_qr = compute_residuals(Z_no_Q, y, theta_qr);
residual_qr_stored_Q = compute_residuals(Z, y, theta_qr_stored_Q);

% Display results
fprintf('Residual (Normal Equation): %.5f\n', residual_normal);
fprintf('Residual (QR Decomposition): %.5f\n', residual_qr);
fprintf('Residual (QR with stored Q): %.5f\n', residual_qr_stored_Q);

% Calculate FLOPs for PCA (Eigenvalue Decomposition)
calculate_flops_pca_eigen(X_std);

% Calculate FLOPs for PCA (QR Decomposition)
calculate_flops_pca_qr(X_std);

% Calculate FLOPs for Linear Regression (Normal Equation)
calculate_flops_linear_regression_normal(X_std, y);

% Calculate FLOPs for Linear Regression (QR Decomposition)
calculate_flops_linear_regression_qr(X_std, y);