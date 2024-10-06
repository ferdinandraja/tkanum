function [R, eigenvalues] = householder_qr_no_Q(A)
    [m, n] = size(A);
    R = A; % Copy A into R for transformation
    eigenvalues = zeros(n, 1); % Preallocate for eigenvalues
    for k = 1:n
        % Householder vector
        x = R(k:m, k);
        e1 = zeros(length(x), 1);
        e1(1) = 1;
        v_k = sign(x(1)) * norm(x) * e1 + x;
        v_k = v_k / norm(v_k); % Normalize
        
        % Apply Householder transformation directly to R
        R(k:m, :) = R(k:m, :) - 2 * v_k * (v_k' * R(k:m, :));
        
        % Capture the approximate eigenvalues (diagonal elements of R)
        eigenvalues(k) = R(k, k); 
    end
end