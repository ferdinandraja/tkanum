function residual = compute_residuals(Z, y, theta)
    Z_aug = [ones(size(Z, 1), 1) Z]; % Add intercept term
    y_pred = Z_aug * theta;
    residual = norm(y - y_pred); % Compute norm of residuals
end