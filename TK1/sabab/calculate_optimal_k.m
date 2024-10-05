function [optimal_k, eigenvalues, eigenvectors] = calculate_optimal_k(Sigma, threshold)
    % Step 1: Get eigenvalues of the covariance matrix

    % Step 2: QR decomposition (Householder with stored Q)
    [Q, R] = householder_qr(Sigma);
    
    % Eigenvalues and eigenvectors from QR decomposition
    eigenvalues = diag(R);
    [~, idx] = sort(eigenvalues, 'descend'); % Sort eigenvalues
    
    eigenvectors = Q(:, idx); % Sorted eigenvectors
    
    % Step 2: Compute cumulative explained variance
    total_variance = sum(eigenvalues);
    cumulative_variance = cumsum(eigenvalues) / total_variance;
    
    % Step 3: Find the smallest k where the cumulative variance exceeds the threshold
    optimal_k = find(cumulative_variance >= threshold, 1);  % Find first k where cumulative variance >= threshold
    
    % Display cumulative variance for reference
    fprintf('Cumulative Variance:\n');
    disp(cumulative_variance);
end