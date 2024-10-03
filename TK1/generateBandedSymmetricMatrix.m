function A = generateBandedSymmetricMatrix(n, p)
    % Initialize the matrix with zeros
    A = zeros(n, n);
    
    % Populate the matrix within the bandwidth
    for i = 1:n
        for j = max(1, i-p):min(n, i+p)
            A(i, j) = randn;  % Fill with random values; use rand, randn, or a specific distribution
        end
    end
    
    % Make the matrix symmetric
    A = triu(A) + triu(A, 1)';  % Take the upper triangle and add its transpose without the diagonal
    
    % Optional: Ensure positive definiteness (if required, e.g., for Cholesky)
    % One way to ensure positive definiteness is to add n*p to the diagonal elements
    A = A + n*p*eye(n);
end
