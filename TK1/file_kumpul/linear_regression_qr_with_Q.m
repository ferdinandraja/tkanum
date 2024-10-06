function theta = linear_regression_qr_with_Q(Z, y)
    Z_aug = [ones(size(Z, 1), 1) Z]; % Add intercept term
    [Q, R] = householder_qr(Z_aug);              % QR decomposition (Householder with stored Q)
    theta = R \ (Q' * y);             % Solve linear system using stored Q
end
