function Wolfe = Wolfe_sum (kernel_Value, phi)

    N = size (phi, 1);
    Wolfe = 0;
    for i = 1:N
        for j = 1:N
            Wolfe = Wolfe - (kernel_Value(i, j) * phi(i,1) * phi(j,1));
        end
        Wolfe = Wolfe + kernel_Value(i,i) * phi(i,1);
    end

end
