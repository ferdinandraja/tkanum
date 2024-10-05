function theta = linear_regression_qr_no_Q(Z, y)
    % Add intercept term to Z
    Z_aug = [ones(size(Z, 1), 1) Z]; % Augmented matrix with intercept
    
    % Initialize R to be Z_aug and y_copy to be y
    [m, n] = size(Z_aug);
    R = Z_aug; % Start with Z_aug as the matrix to transform
    y_copy = y; % Copy y to apply the transformations
    
    % Apply Householder reflections directly to R and y
    for k = 1:n
        % Get the Householder vector
        x = R(k:m, k); % Extract column from R
        e1 = zeros(length(x), 1);
        e1(1) = 1;
        v_k = sign(x(1)) * norm(x) * e1 + x; % Householder vector
        v_k = v_k / norm(v_k); % Normalize
        
        % Apply the Householder reflection to R and y_copy
        R(k:m, :) = R(k:m, :) - 2 * v_k * (v_k' * R(k:m, :)); % Apply to R
        y_copy(k:m) = y_copy(k:m) - 2 * v_k * (v_k' * y_copy(k:m)); % Apply to y
    end
    
    % Solve the upper triangular system R * theta = y_copy
    theta = R(1:n, 1:n) \ y_copy(1:n); % Only use the top n rows/columns of R
end
