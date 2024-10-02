function [L, U] = BlockLU(A, blockSize)
    n = size(A, 1);
    L = eye(n);
    U = zeros(n);
    for i = 1:blockSize:n
        endIdx = min(i + blockSize - 1, n);
        [L(i:endIdx, i:endIdx), U(i:endIdx, i:endIdx)] = lu(A(i:endIdx, i:endIdx));
        if endIdx < n
            L(endIdx+1:n, i:endIdx) = A(endIdx+1:n, i:endIdx) / U(i:endIdx, i:endIdx);
            U(i:endIdx, endIdx+1:n) = L(i:endIdx, i:endIdx) \ A(i:endIdx, endIdx+1:n);
            A(endIdx+1:n, endIdx+1:n) = A(endIdx+1:n, endIdx+1:n) - L(endIdx+1:n, i:endIdx) * U(i:endIdx, endIdx+1:n);
        end
    end
end
