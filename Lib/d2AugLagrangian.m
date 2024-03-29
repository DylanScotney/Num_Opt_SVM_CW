function d2L = d2AugLagrangian(d2F, d2C_e, d2Psi, a, mu_e, mu_I, lambda_I)
% Returns the hessian of the augmented lagrangian
d2L = -d2F + d2C_e(mu_e) + d2Psi(a, mu_I, lambda_I);
end