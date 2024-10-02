function x = solveLU(L, U, P, b)
    y = forwardElimination(L, P*b);
    x = backwardSubstitution(U, y);
end