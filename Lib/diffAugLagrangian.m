function dL = diffAugLagrangian(dF, dC_e, C_e, dPsi, a, mu_e, lambda_e, mu_I, lambda_I)

dL = -dF(a) - lambda_e*dC_e + 1/(2*mu_e)*2*dC_e*C_e(a)+ dPsi(a, mu_I, lambda_I);
end