function testTimeandFlops()
    matrix_sizes = randi([4, 20], 1, 5); % Generate 5 random matrix sizes between 4 and 20
    for i = 1:length(matrix_sizes)
        n = matrix_sizes(i);
        A = rand(n); % Generate a random n x n matrix
        fprintf('\nTesting LU methods for %d x %d matrix:\n', n, n);
        compare_lu_methods(A,n);
    end
end

function compare_lu_methods(A,n)
    % LU Pivoting Method
    tic;
    [L_pivoting, U_pivoting, p] = lu_pivoting(A);
    time_pivoting = toc;
    flops_pivoting = (2/3) * size(A, 1)^3;
    fprintf('LU Pivoting: Time = %.4f s, FLOPs = %.0f\n', time_pivoting, flops_pivoting);

    % Recursive LU Method
    tic;
    [L_recursive, U_recursive] = RecursiveLU(A);
    time_recursive = toc;
    flops_recursive = estimate_recursive_flops(size(A, 1));
    fprintf('Recursive LU: Time = %.4f s, FLOPs = %.0f\n', time_recursive, flops_recursive);

    % Block LU Method
    tic;
    [L_block, U_block] = BlockLU(A, n);
    time_block = toc;
    flops_block = estimate_block_flops(size(A, 1), n);
    fprintf('Block LU: Time = %.4f s, FLOPs = %.0f\n', time_block, flops_block);
end

