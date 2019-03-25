function f = F(a, H)
%==========================================================================
% The function we are aiming to maximise subject to some given restraints
%==========================================================================
f = sum(a) - 1/2 * a'*H*a; 
end
