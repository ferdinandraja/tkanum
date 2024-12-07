function [x,y] = solveLU(L, U, b)
    y = forwardElimination(L, b);
    x = backwardSubstitution(U, b);
end