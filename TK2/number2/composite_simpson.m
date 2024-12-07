function integral = composite_simpson(a, b, n, y)
    if mod(n, 2) ~= 0
        error('Number of subdivisions n must be even for Simpson''s method.');
    end
    h = (b - a) / n;
    x = linspace(a, b, n + 1);
    
    y_vals = log_loss(x, y);
    
    integral = y_vals(1) + y_vals(end) + 4 * sum(y_vals(2:2:end-1)) + 2 * sum(y_vals(3:2:end-2));
    integral = integral * h / 3;
end