function d2psi = d2Psi(a, mu_I, lambda_I)

d2psi = mu_I*eye(length(a));

for i = 1:length(a)
    if(a(i) - mu_I*lambda_I(i) > 0)
        d2psi(i,i) = 0;
    end
end

end