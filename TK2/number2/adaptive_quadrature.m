function [integral, N_total] = adaptive_quadrature(a, b, TOL, y)
    % Adaptive quadrature using recursive bisection
    N_total = 0;
    
    function S = approximation(a, b)
        c = (a + b) / 2;
        f_a = log_loss(a, y);
        f_b = log_loss(b, y);
        f_c = log_loss(c, y);

        C = (a + b) / 2;
        S_a_b = (b - a) * (f_a + f_b) / 2;
        S_a_c = (c - a) * (f_a + f_c) / 2;
        S_c_b = (b - c) * (f_c + f_b) / 2;
        S = S_a_c + S_c_b;

        N_total += 1;
    end
    
    function integral = quad_recursive(a, b)
        S_a_b = approximation(a, b);
        S_a_c = approximation(a, (a + b) / 2);
        S_c_b = approximation((a + b) / 2, b);
        
        if abs(S_a_b - S_a_c - S_c_b) <= 3 * TOL * (b - a) * (b - a) / (b_orig - a_orig)
            integral = S_a_b;
        else
            integral = quad_recursive(a, (a + b) / 2) + quad_recursive((a + b) / 2, b);
        end
    end

    a_orig = a;
    b_orig = b;
    
    integral = quad_recursive(a, b);
end