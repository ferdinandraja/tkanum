function L = cholesky(A, p)
    % A: symmetric positive definite matrix
    % p: bandwidth parameter (assumes p = q)
    
    n = size(A, 1);
    L = zeros(n, n);  % Initialize the L matrix as zero
    
    for i = 1:n
        for j = max(1, i-p):i
            if i == j
                % Diagonal element calculation
                sum_diag = 0;
                for k = max(1, i-p):(i-1)
                    sum_diag = sum_diag + L(i, k)^2;
                end
                L(i, i) = sqrt(A(i, i) - sum_diag);
            else
                % Off-diagonal element calculation
                sum_offdiag = 0;
                for k = max(1, i-p):(j-1)
                    sum_offdiag = sum_offdiag + L(i, k) * L(j, k);
                end
                L(i, j) = (A(i, j) - sum_offdiag) / L(j, j);
            end
        end
    end
end
