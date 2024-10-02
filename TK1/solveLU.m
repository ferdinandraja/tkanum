function x = solveLU(L, U, b)
    y = forwardElimination(L, b);
    x = backwardSubstitution(U, b);
end