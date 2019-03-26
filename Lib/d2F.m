function d2f = d2F(H)
% Returns the hessian of the L_D (see eqn 1.12 of accompanying report)
d2f = -1/2*(H+H');
end
