function [isNonSingular, A] = checkIfNonSingular(A)
    % Check if the matrix is non-singular by examining the determinant
    if det(A) == 0
        disp('Matrix is singular (determinant is zero).');
        isNonSingular = false;
    else
        % Additionally check the condition number for more confidence
        condNumber = cond(A);
        if isinf(condNumber)
            disp('Matrix is nearly singular (condition number is infinite).');
            isNonSingular = false;
        else
            disp(['Matrix is non-singular (condition number: ', num2str(condNumber), ').']);
            isNonSingular = true;
        end
    end
end