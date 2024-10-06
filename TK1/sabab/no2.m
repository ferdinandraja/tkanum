data = csvread('pokindex_data.csv');
X = data(:, 1:end-1); % Features
y = data(:, end);     % Response variable

% Step 1: Standardize the data
[X_std, mu, sigma] = standardize(X);

% Step 2: Compute covariance matrix
Sigma = covariance(X_std);

% Step 3: Perform PCA using QR decomposition (Householder with stored Q)
[Z_no_Q, eigenvalues_no_Q] = pca_householder_no_Q(X_std,Sigma);  % k = 3 components
[Z, eigenvalues, eigenvectors] = pca_householder(X_std, Sigma);  % Example with k=3

% Step 4: Linear regression using the three approaches

% Measure time for Normal Equation
tic;
theta_normal = linear_regression_normal(Z, y);
time_normal = toc;

% Measure time for QR Decomposition without Q
tic;
theta_qr = linear_regression_qr(Z_no_Q, y);
time_qr = toc;

% Measure time for QR Decomposition with stored Q
tic;
theta_qr_stored_Q = linear_regression_qr_with_Q(Z, y);
time_qr_stored_Q = toc;

fprintf('Time (Normal Equation): %.5f seconds\n', time_normal);
fprintf('Time (QR Decomposition): %.5f seconds\n', time_qr);
fprintf('Time (QR with stored Q): %.5f seconds\n', time_qr_stored_Q);
% Step 5: Compute residuals for comparison
residual_normal = compute_residuals(Z, y, theta_normal);
residual_qr = compute_residuals(Z_no_Q, y, theta_qr);
residual_qr_stored_Q = compute_residuals(Z, y, theta_qr_stored_Q);

% Display results
fprintf('Residual (Normal Equation): %.5f\n', residual_normal);
fprintf('Residual (QR Decomposition): %.5f\n', residual_qr);
fprintf('Residual (QR with stored Q): %.5f\n', residual_qr_stored_Q);