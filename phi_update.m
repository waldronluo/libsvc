function phi = phi_update (MKernel, phi, C)

    N = size(phi, 1);
    for i = 1:N
        % update subscript of phi
        if (i < N )
            k1 = i;
            k2 = i + 1;
        else
            k1 = N;
            k2 = 1;
        end

        %update phi
        cons = phi(k1, 1) + phi (k2, 1);
        update_phi = phi;
        update_phi(k1, 1) = (MKernel (k1, k1) - MKernel (k2, k2) ...
        - cons * (MKernel (k1, k2) + MKernel (k2, k1) - 2 * MKernel (k2, k2)))...
        / (2 * (MKernel(k1, k1) + MKernel(k2, k2) - MKernel(k2, k1) - MKernel(k1, k2)));
        update_phi(k2, 1) = cons - update_phi(k1, 1);

        upper_phi = phi;
        upper_phi(k1, 1) = cons - 0;
        upper_phi(k2, 1) = 0;

        lower_phi = phi;
        lower_phi(k1, 1) = 0;
        lower_phi(k2, 1) = cons - 0;

        phi_group = [update_phi, upper_phi, lower_phi];
        var_sum = zeros (1,3);
        var_sum(1) = Wolfe_sum(MKernel, update_phi);
        var_sum(2) = Wolfe_sum(MKernel, upper_phi);
        var_sum(3) = Wolfe_sum(MKernel, lower_phi);

        [x, ix] = min(var_sum);
        phi = phi_group(:, ix);

    end

end
