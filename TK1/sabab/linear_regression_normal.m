function theta = linear_regression_normal(Z, y)
    Z_aug = [ones(size(Z, 1), 1) Z]; % Add intercept term
    theta = (Z_aug' * Z_aug) \ (Z_aug' * y); % Normal equation solution
end