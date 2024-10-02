Ns = [16, 64, 128, 256, 512, 1000];
results = [];  % Initialize as an empty matrix.

for N = Ns
    PQs = {[1, 1], [2, 1], [3, 4], [floor(N/4), floor(N/4)], [floor(N/2), floor(N/2)]};
    for idx = 1:length(PQs)
        pq = PQs{idx};
        p = pq(1);
        q = pq(2);

        A = generateBandedMatrix(N, p, q);
        b = rand(N, 1);  % Example right-hand side vector

        % Test Recursive LU
        tic;
        [L, U] = RecursiveLU(A);
        x = solveLU(L, U, eye(N), b);  % Assuming solveLU can handle the permutation as identity
        elapsedTime = toc;
        totalFlops = 2 * N^2;  % Simplified estimation for recursive
        results = [results; [N, p, q, elapsedTime, totalFlops, 1]];  % Use 1 to indicate Recursive LU

        % Test Block LU
        blockSize = min(32, N);  % Arbitrary block size choice
        tic;
        [L, U] = BlockLU(A, blockSize);
        x = solveLU(L, U, eye(N), b);
        elapsedTime = toc;
        totalFlops = 2 * N^3 / (blockSize^2);  % Simplified estimation for block
        results = [results; [N, p, q, elapsedTime, totalFlops, 2]];  % Use 2 to indicate Block LU
    end
end

% Display the results
for i = 1:size(results, 1)
    method = 'Recursive LU';
    if results(i, 6) == 2
        method = 'Block LU';
    end
    fprintf('Method: %s, N: %d, p: %d, q: %d, Time: %.4f s, Estimated FLOPs: %.2f\n', ...
            method, results(i, 1), results(i, 2), results(i, 3), results(i, 4), results(i, 5));
end
