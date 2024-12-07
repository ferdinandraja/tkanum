function [L, U] = BlockLU(A, blockSize)
    % Iterative block LU decomposition
    % A is the input matrix
    % blockSize is the size of blocks used for decomposition

    n = size(A, 1); % Determine the size of the matrix
    if n ~= size(A, 2)
        error('Matrix must be square');
    end

    L = eye(n); % Initialize L as an identity matrix of size n
    U = zeros(n); % Initialize U as an empty matrix of size n

    % Iteratively process each block
    for startIdx = 1:blockSize:n
        endIdx = min(startIdx + blockSize - 1, n); % Compute the end index of the block

        % Decompose the current block
        [L_k, U_k] = lu(A(startIdx:endIdx, startIdx:endIdx), 'vector');
        L(startIdx:endIdx, startIdx:endIdx) = L_k;
        U(startIdx:endIdx, startIdx:endIdx) = U_k;

        % Update the blocks to the right and below the current block
        if endIdx < n
            % Compute the multipliers for the block below
            L(endIdx+1:n, startIdx:endIdx) = A(endIdx+1:n, startIdx:endIdx) / U_k;

            % Update the block below
            A(endIdx+1:n, endIdx+1:n) = A(endIdx+1:n, endIdx+1:n) - L(endIdx+1:n, startIdx:endIdx) * U_k;

            % Update the block to the right
            U(startIdx:endIdx, endIdx+1:n) = L_k \ A(startIdx:endIdx, endIdx+1:n);
        end
    end
end
