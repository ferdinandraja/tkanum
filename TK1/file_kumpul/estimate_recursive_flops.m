function flops = estimate_recursive_flops(n)
    if n == 1
        flops = 0;
    else
        k = floor(n / 2);
        flops = estimate_recursive_flops(k) * 2 + 2 * k^2 * (n - k);
    end
end
