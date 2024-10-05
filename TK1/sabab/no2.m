data = csvread('pokindex_data.csv');
X = data(:, 1:end-1); % Features
y = data(:, end);     % Response variable

% Step 1: Standardize the data
[X_std, mu, sigma] = standardize(X);

% Step 2: Compute covariance matrix
Sigma = covariance(X_std);

% Step 3: Perform PCA using QR decomposition (Householder with stored Q)
[Z_no_Q, eigenvalues_no_Q] = pca_householder_no_Q(X_std,Sigma, 3);  % k = 3 components
[Z, eigenvalues, eigenvectors] = pca_householder(X_std, Sigma ,3);  % Example with k=3

% Compare the first few eigenvalues
disp('Eigenvalues without stored Q:');
disp(eigenvalues_no_Q);

disp('Eigenvalues with stored Q:');
disp(eigenvalues);

% Step 4: Compare the transformed data (Z) for the first 5 rows
disp('First 5 rows of Z without stored Q:');
disp(Z_no_Q(1:5, :));

disp('First 5 rows of Z with stored Q:');
disp(Z(1:5, :));

% Step 4: Linear regression using the three approaches

% 1. Normal Equation
theta_normal = linear_regression_normal(Z, y);

% 2. QR Decomposition (Householder for odd groups)
theta_qr = linear_regression_qr(Z_no_Q, y);

% 3. QR Decomposition with stored Q (Householder for odd groups)
theta_qr_stored_Q = linear_regression_qr_with_Q(Z, y);
disp(theta_normal)
disp(theta_qr_stored_Q)
disp(theta_qr)

% Step 5: Compute residuals for comparison
residual_normal = compute_residuals(Z, y, theta_normal);
residual_qr = compute_residuals(Z_no_Q, y, theta_qr);
residual_qr_stored_Q = compute_residuals(Z, y, theta_qr_stored_Q);

% Display results
fprintf('Residual (Normal Equation): %.5f\n', residual_normal);
fprintf('Residual (QR Decomposition): %.5f\n', residual_qr);
fprintf('Residual (QR with stored Q): %.5f\n', residual_qr_stored_Q);