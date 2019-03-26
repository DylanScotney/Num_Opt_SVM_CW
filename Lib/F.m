function f = F(a, H)
% Dual problem, L_D we are aiming to maximise subject to given constraints.
% see eqn 1.12 of accompanying report for more info

f = sum(a) - 1/2 * a'*H*a; 
end
