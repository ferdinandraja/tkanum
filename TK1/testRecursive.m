function testRecursive()
    maxN = 100000000000; % Adjust as needed to find the crash point
    for N = 1:1000:maxN
        try
            A = rand(N, N); % Generate a random N x N matrix
            [L, U] = recursiveLU2(A);
            disp(['Success for N = ', num2str(N)]);
        catch ME
            disp(['Failed at N = ', num2str(N)]);
            disp(getReport(ME));
            break;
        end
    end
end