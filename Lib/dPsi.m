function dpsi = dPsi(a, mu_I, lambda_I)
% Returns the differential of the inequality constraints func

dpsi = -lambda_I + a/mu_I;

for i = 1:length(a)
    if(a(i) - mu_I*lambda_I(i) > 0)
        dpsi(i) = 0;
    end
end

end