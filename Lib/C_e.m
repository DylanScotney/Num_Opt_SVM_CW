function c_e = C_e(a, y)
% Equality constraint function corresponding to const. sum(a_i*y_i) = 0
% Input:
%   - a:        usually a syms variable which we are trying to optimise 
%   - y:        The classification of each datapoint.  
c_e = sum(a.*y); 
end