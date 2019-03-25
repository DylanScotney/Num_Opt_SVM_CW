function L = augLagrangian(F, C_e, Psi, a, mu_e, lambda_e, mu_I, lambda_I)
% Minimisation problem w/ constraints as augmented lagrangian

L = F(a) - lambda_e*C_e(a) + 1/(2*mu_e)*(C_e(a))^2 + Psi(a, mu_I, lambda_I);

end