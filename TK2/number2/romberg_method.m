function integral = romberg_method(a, b, m, y)
    R = zeros(m, m);

    h = (b - a);
    R(1,1) = (log_loss(a, y) + log_loss(b, y)) * h / 2;
    
    for j = 2:m
        h = h / 2;
        N = 2^(j-2);  
        sum = 0;
        for i = 1:N
            x = a + (2*i - 1) * h;
            sum = sum + log_loss(x, y);
        end
        R(j,1) = 0.5 * R(j-1,1) + sum * h;
        
        for k = 2:j
            R(j,k) = (4^(k-1) * R(j,k-1) - R(j-1,k-1)) / (4^(k-1) - 1);
        end
    end
    
    integral = R(m,m);
end