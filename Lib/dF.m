function df = dF(a, H)
% Derivative of the function we are optimising subject to some constraints
df = ones(length(a),1) - 1/2 * (H + H')*a;
end