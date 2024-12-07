function [optimal_k, eigenvalues, eigenvectors] = calculate_optimal_k_eigen(Sigma, threshold)
    % Step 1: Perform eigenvalue decomposition of the covariance matrix
    [eigenvectors, D] = eig(Sigma); % D is a diagonal matrix with eigenvalues
    
    % Extract the eigenvalues from the diagonal of D
    eigenvalues = diag(D);
    
    % Step 2: Sort eigenvalues in descending order
    [eigenvalues, idx] = sort(eigenvalues, 'descend');
    eigenvectors = eigenvectors(:, idx);
    
    % Step 3: Compute the cumulative explained variance
    total_variance = sum(eigenvalues);
    cumulative_variance = cumsum(eigenvalues) / total_variance;
    
    % Step 4: Find the smallest k where the cumulative variance exceeds the threshold
    optimal_k = find(cumulative_variance >= threshold, 1);
    
    % Display cumulative variance for reference
    fprintf('Cumulative Variance for each component:\n');
    disp(cumulative_variance);
end
