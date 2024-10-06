function analyzeMatrixCondition(A,N,p,q)
    % Generate a banded matrix
    
    
    % Calculate the condition number
    condNum = cond(A);
    
    % Solve a linear system Ax = b
    b = ones(N, 1);  % Example right-hand side
    x = A \ b;
    r = b - A * x;  % Residual of the solution
    
    % Display results
    fprintf('Matrix Size N: %d, p: %d, q: %d\n', N, p, q);
    fprintf('Condition Number: %f\n', condNum);
    fprintf('Residual Norm: %e\n', norm(r));
    
    % Analyze the condition
    if condNum < 100
        disp('The matrix is well-conditioned.');
    elseif condNum > 1000
        disp('The matrix is ill-conditioned.');
    else
        disp('The matrix condition is moderate.');
    end
end