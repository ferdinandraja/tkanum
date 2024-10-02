Ns = [16, 64, 128, 256, 512, 1000];

% Collect results in arrays for later analysis
results = [];  % Store N, p, q, time, and estimated FLOPs

for N = Ns
    PQs = {[1, 1], [2, 1], [3, 4], [floor(N/4), floor(N/4)], [floor(N/2), floor(N/2)]};

    for idx = 1:length(PQs)
        pq = PQs{idx};
        p = pq(1);
        q = pq(2);

        A = generateBandedMatrix(N, p, q);
        [isNonSingular, A] = checkIfNonSingular(A);

        if ~isNonSingular
            disp('Regenerating matrix to ensure it is non-singular...');
            while ~isNonSingular
                A = generateBandedMatrix(N, p, q);
                [isNonSingular, A] = checkIfNonSingular(A);
            end
        end
        b = rand(N, 1);  % Example right-hand side vector

        tic;  % Start timer
        [L, U, P] = lu_pivoting(A);
        x = solveLU(L, U, b);
        elapsedTime = toc;  % Stop timer and record elapsed time

        % Calculate FLOPs
        flopsLU = 2 * N * p * q;  % Simplified estimation for LU decomposition
        flopsSolve = (p + 1) * N + (q + 1) * N;  % For forward elimination and backward substitution

        totalFlops = flopsLU + flopsSolve;

        % Display and record results
        disp(['Size N: ', num2str(N), ', p: ', num2str(p), ', q: ', num2str(q), ...
              ', Time: ', num2str(elapsedTime), 's, Estimated FLOPs: ', num2str(totalFlops)]);
        
        results = [results; N, p, q, elapsedTime, totalFlops];
    end
end

