function L = augLagrangian(F, C_e, Psi, a, mu_e, lambda_e, mu_I, lambda_I)
% The augmented lagrangian function to minimise as explained by equation
% 1.22 of accompanying report

L = -F(a) - lambda_e*C_e(a) + 1/(2*mu_e)*(C_e(a))^2 + Psi(a, mu_I, lambda_I);

end