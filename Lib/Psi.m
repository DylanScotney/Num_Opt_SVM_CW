function psi = Psi(a, mu_I, lambda_I)
% Outputs the sum of all the inequality constaint functions C_I_i = alpha_i
% Inputs: 
%   - a:            Usually a syms var which we are looking to optimise
%   - mu_I:         The penalty parameter 
%   - lambda_I:     A vector of length(a) corresponding to the lagrangian
%                   multipliers for each inequality constaint a_i

psi = 0;

for i=1:length(a)
    
    if(a(i) - mu_I*lambda_I(i) <=0)
        psi = psi - lambda_I(i)*(a(i)) + 1/(2*mu_I)*(a(i))^2;
    else
        psi = psi - mu_I/2 * (lambda_I(i))^2;
    end
    
end

end