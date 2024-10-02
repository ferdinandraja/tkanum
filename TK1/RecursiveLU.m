function [L, U] = RecursiveLU(A)
    n = size(A, 1);
    if n == 1
        L = 1;
        U = A;
        return;
    end
    
    k = floor(n / 2);  % Half the size of the matrix
    A11 = A(1:k, 1:k);
    A12 = A(1:k, k+1:end);
    A21 = A(k+1:end, 1:k);
    A22 = A(k+1:end, k+1:end);
    
    [L11, U11] = RecursiveLU(A11);
    L12 = L11 \ A12;
    U21 = A21 / U11;
    
    [L22, U22] = RecursiveLU(A22 - U21 * L12);
    
    L = [L11 zeros(k, n-k); U21 L22];
    U = [U11 L12; zeros(n-k, k) U22];
end
