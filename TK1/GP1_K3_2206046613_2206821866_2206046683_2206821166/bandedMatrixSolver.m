Ns = [16, 64, 128, 256, 512, 1000];

% Collect results in arrays for later analysis
results = [];  % Store N, p, q, time, FLOPs, and residual error

for N = Ns
    PQs = {[1, 1], [2, 1], [3, 4], [floor(N/4), floor(N/4)], [floor(N/2), floor(N/2)]};

    for idx = 1:length(PQs)
        pq = PQs{idx};
        p = pq(1);
        q = pq(2);

        A = generateBandedMatrix(N, p, q);
        analyzeMatrixCondition(A,N,p,q)
        [isNonSingular, A] = checkIfNonSingular(A);

        if ~isNonSingular
            disp('Matrix was singular, regenerating...');
            while ~isNonSingular
                A = generateBandedMatrix(N, p, q);
                [isNonSingular, A] = checkIfNonSingular(A);
            end
        end
        b = rand(N, 1);  % Example right-hand side vector

        % LU Pivoting
        tic;
        [L, U, P] = lu_pivoting(A);
        solveLU(L, U, b);
        elapsedTime = toc;
        flopsLU =  2 * N^3; % Rough estimation for LU decomposition
        R = A - L*U;
        resLU = norm(R, 'fro');
        disp(['LU Pivoting - Solve LU: Time: ', num2str(elapsedTime), 's, FLOPs: ', num2str(flopsLU), ', Residual: ', num2str(resLU)]);

        % Recursive LU
        tic;
        [L, U] = RecursiveLU(A);
        solveLU(L, U, b);
        elapsedTime = toc;
        flopsRecursiveLU = estimate_recursive_flops(N) ; % Assuming similar complexity
        R = A - L*U;
        resRecursiveLU = norm(R, 'fro');
        disp(['Recursive LU - Solve LU: Time: ', num2str(elapsedTime), 's, FLOPs: ', num2str(flopsRecursiveLU), ', Residual: ', num2str(resRecursiveLU)]);

        % Block LU
        tic;
        [L, U] = BlockLU(A, N/2);
        solveLU(L, U, b);
        elapsedTime = toc;
        flopsBlockLU =estimate_block_flops(N, N/2); % Assuming similar complexity for blocks
        R = A - L*U;
        resBlockLU = norm(R, 'fro');
        disp(['Block LU - Solve LU: Time: ', num2str(elapsedTime), 's, FLOPs: ', num2str(flopsBlockLU), ', Residual: ', num2str(resBlockLU)]);

        % Save the results
        results = [results; N, p, q, elapsedTime, flopsLU + flopsRecursiveLU + flopsBlockLU, resLU, resRecursiveLU, resBlockLU];
    end
end
