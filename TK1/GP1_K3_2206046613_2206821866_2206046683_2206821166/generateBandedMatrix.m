function A = generateBandedMatrix(N, p, q)
    A = zeros(N, N);
    for i = 1:N
        for j = max(1, i-p):min(N, i+q)
            A(i, j) = rand();  % Random fill, or specific values if required
        end
    end
end