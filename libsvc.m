function W = libsvc (M, C, q)

%=========================================================================================
% libsvc is the function of support vector clustering based on []'s work.
% M is the input matrix contains the dataset that needed to be clustering
% C is the constant for penalty
% q is the scale parameter for Gaussian Kernel
% ========================================================================================
% N is the number of cases

    N = size(M, 1);

    % Should implement constrained optimization problem. 

    phi_init = rand(N, 1);
    phi = phi_init ./ sum(phi_init);

    % Now we need to update phi

    M_GaussianKernel = zeros(N, N);


    % Can be better because M(i,j) = M(j,i)
    for i = 1:N
        for j = 1:N
            M_GaussianKernel(i,j) = gaussianKernel (M(i,:)', M(j,:)', q);
        end
    end

    Wolfe = Wolfe_sum(M_GaussianKernel, phi);

    % For debug, some storage cells
    WA = [];
    PA = [];

    %update with constrain as cons

    Wolfe_old = 2 * Wolfe + 1e-5;
    Wolfe_new = Wolfe;
    phi_old = phi;
    phi_new = phi_old;

    WA = [WA,Wolfe_new];
    PA = [PA, phi];

    while (1)
        if (abs(Wolfe_old - Wolfe_new) < 1e-7 && (phi_old - phi_new)' * (phi_old - phi_new) < 1e-7)
            break;
        else 
            phi_old = phi_new;
            phi_new = phi_update (M_GaussianKernel, phi, C);
            phi = phi_new;
        end
        Wolfe_old = Wolfe_new;
        Wolfe_new = Wolfe_sum(M_GaussianKernel, phi);

        WA = [WA, Wolfe_new];
        PA = [PA,phi];
    end
    W = Wolfe_new;
end
