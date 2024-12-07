function [Q, R] = householder_qr(A)
    [m, n] = size(A);
    Q = eye(m); % Initialize Q as identity matrix
    R = A;     % Copy A into R for transformation
    for k = 1:n
        % Householder vector
        x = R(k:m, k);
        e1 = zeros(length(x), 1);
        e1(1) = 1;
        v_k = sign(x(1)) * norm(x) * e1 + x;
        v_k = v_k / norm(v_k); % Normalize
        
        % Update R and Q with Householder reflection
        R(k:m, :) = R(k:m, :) - 2 * v_k * (v_k' * R(k:m, :));
        Q(k:m, :) = Q(k:m, :) - 2 * v_k * (v_k' * Q(k:m, :));
    end
    Q = Q'; % Return transposed Q
end