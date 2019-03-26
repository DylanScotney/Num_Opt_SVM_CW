function d2c_e = d2C_e(y)
% Returns the hessian of the equality constraint function
d2c_e = zeros(length(y));

for j = 1:length(y)
    for i=1:length(y)
        d2c_e(i,j) = y(i)*y(j); 
    end
end

end