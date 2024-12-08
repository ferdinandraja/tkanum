function [integral, N_total] = adaptive_quadrature(a, b, TOL, y)
    N_total = 0;

    function [S, fa, fb, fc] = initial_approximation(a, b)
        c = (a + b) / 2;
        fa = log_loss(a,y);
        fb = log_loss(b,y);
        fc = log_loss(c,y);
        S = (b - a) * (fa + 4 * fc + fb) / 6;
        N_total = N_total + 3;
    end

    function S = quad_recursive(a, b, S, fa, fb, fc, TOL)
        c = (a + b) / 2;
        d = (a + c) / 2;
        e = (c + b) / 2;

        fd = log_loss(d,y);
        fe = log_loss(e,y);
        N_total = N_total + 2;

        S_left  = (c - a) * (fa + 4 * fd + fc) / 6;
        S_right = (b - c) * (fc + 4 * fe + fb) / 6;

        S_refined = S_left + S_right;
        error_estimate = abs(S_refined - S);

        if error_estimate <= 15 * TOL
            S = S_refined + (S_refined - S) / 15;
        else
            S = quad_recursive(a, c, S_left, fa, fc, fd, TOL / 2) + quad_recursive(c, b, S_right, fc, fb, fe, TOL / 2);
        end
    end

    [S_initial, fa, fb, fc] = initial_approximation(a, b);
    integral = quad_recursive(a, b, S_initial, fa, fb, fc, TOL);

end