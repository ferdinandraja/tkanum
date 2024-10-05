function [optimal_k, eigenvalues, R] = calculate_optimal_k(Sigma, threshold)
    % Step 1: Get eigenvalues of the covariance matrix
    [R, ~] = householder_qr(Sigma);
    eigenvalues = diag(R);  % Eigenvalues are the diagonal elements of R
    eigenvalues = sort(eigenvalues, 'descend');  % Sort eigenvalues in descending order

    % Step 2: Compute cumulative explained variance
    total_variance = sum(eigenvalues);
    cumulative_variance = cumsum(eigenvalues) / total_variance;

    [~, idx] = sort(eigenvalues, 'descend');
    eigenvalues = eigenvalues(idx);
    
    % Step 3: Find the smallest k where the cumulative variance exceeds the threshold
    optimal_k = find(cumulative_variance >= threshold, 1);  % Find first k where cumulative variance >= threshold
    
    % Display cumulative variance for reference
    fprintf('Cumulative Variance:\n');
    disp(cumulative_variance);
end