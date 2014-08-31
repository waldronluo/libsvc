function value = gaussianKernel (X1, X2, q)
    assert (size(X1, 2) == 1 && size(X2, 2) == 1, "X1 and X2 Should be column vector.");
    Xdiff = (X1 - X2);
    value = exp(-q * Xdiff' * Xdiff);
end

