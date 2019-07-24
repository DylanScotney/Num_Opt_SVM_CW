%% Integration testing functions used in the optimisation problem
%--------------------------------------------------------------------------

addpath ../Code/lib

%--------------------------------------------------------------------------
%% Integration test for augLagrangian
%--------------------------------------------------------------------------
disp("Integration test for function call of augLagrangian")
clear all

% Test 1: test functionality 
%---------------------------

% Test params
tstH = [4.8143   -6.6393;  -6.6393   10.3069];
tsta = [2;4];
tstlambda_I = [1;2];
tstmu_I = 0.5;
tstmu_e = 2.4;
tstlambda_e = 7;
tstgroup = [-1;1];

% Define expected results
expected = F(tsta, tstH) - tstlambda_e*C_e(tsta, tstgroup)...
         + 1/(2*tstmu_e)*(C_e(tsta, tstgroup))^2 ...
         + Psi(tsta, tstmu_I, tstlambda_I);

% Define function handles for augLagrangian 
f = @(a) F(a, tstH);
c_e = @(a) C_e(a, tstgroup);
psi = @(a, mu_I, lambda_I) Psi(a, mu_I, lambda_I);

% Define L as syms function
L = @(a, mu_e, lambda_e, mu_I, lambda_I) augLagrangian(f, c_e, psi, a,...
                                                        mu_e, lambda_e, ...
                                                        mu_I,lambda_I);
                                                    
result = L(tsta, tstmu_e, tstlambda_e, tstmu_I, tstlambda_I);

if(expected ~= result) 
    result
    expected
    error("augLagangian not working as expected. Test 1 failed")
else
    disp("augLagangian: Test 1 passed")
end


% Test 2: penalty params and lagrane multipliers = 0
%---------------------------------------------------

expected = F(tsta, tstH);
result = L(tsta,realmax,0,realmax,[0;0]);
if(abs(expected - result) > 1e-12) 
    result
    expected
    error("augLagangian not working as expected. Test 2 failed")
else
    disp("augLagangian: Test 2 passed")
end
fprintf("\n")

              

%--------------------------------------------------------------------------
%% Integration test for diffAugLagrangian
%--------------------------------------------------------------------------
disp("Integration test for function call of diffAugLagrangian")
clear all

% Test 1: Test functionality
%---------------------------
% Test params
tstH = [4.8143   -6.6393;  -6.6393   10.3069];
tsta = [2;4];
tstlambda_I = [1;2];
tstmu_I = 0.5;
tstmu_e = 2.4;
tstlambda_e = 7;
tstgroup = [-1;1];

% Define expected results
expected = dF(tsta,tstH) - tstlambda_e*dC_e(tstgroup)...
           + 1/(2*tstmu_e)*2*dC_e(tstgroup)*C_e(tsta, tstgroup)...
           + dPsi(tsta, tstmu_I, tstlambda_I);
       
% Define func handles
df = @(a) dF(a, tstH);
dc_e = dC_e(tstgroup);
dpsi = @ (a, mu_I, lambda_I) dPsi(a, mu_I, lambda_I);
c_e = @(a) C_e(a, tstgroup);

% Define dL as syms func
dL = @(a, mu_e, lambda_e, mu_I, lambda_I) diffAugLagrangian(df, dc_e, c_e,...
                                                            dpsi, a, mu_e,...
                                                            lambda_e, mu_I,...
                                                            lambda_I);
                                                        
result = dL(tsta, tstmu_e, tstlambda_e, tstmu_I, tstlambda_I);

if(~isequal(expected,result)) 
    result
    expected
    error("diffAugLagangian not working as expected. Test 1 failed")
else
    disp("diffAugLagangian: Test 1 passed")
end


% Test 2: Coefficients zero
%--------------------------

expected = dF(tsta, tstH);
result = dL(tsta,realmax, 0, realmax, [0;0]);
if(~isequal(expected,result)) 
    result
    expected
    error("diffAugLagangian not working as expected. Test 2 failed")
else
    disp("diffAugLagangian: Test 2 passed")
end

fprintf("\n")



%%
disp("ALL TESTS PASSED")

                                     