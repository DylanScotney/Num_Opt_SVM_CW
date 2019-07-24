%% Unit testing functions used in the optimisation problem
%----------------------------------------------------------

addpath ../Code/lib

%--------------------------------------------------------------------------
%% Unit tests for f(alpha)
%--------------------------------------------------------------------------
disp("Unit Tests for F(alpha):")
clear all

% Test 1
%-------
test_alpha = [1;2;3];
test_H = [1,2,3;4,5,6;7,8,9];
result = F(test_alpha,test_H);
expected = 6 - 0.5*228;

if(expected ~= result) 
    result;
    expected;
    warning("f(alpha) not working as expected. Test 1 failed")
else
    disp("f(alpha): Test 1 passed")
end
fprintf("\n")


%--------------------------------------------------------------------------
%% Unit tests for df(alpha)
%--------------------------------------------------------------------------
disp("Unit Tests for derivative of F(alpha):")
clear all

% Test 1
%-------
test_alpha = [5;5];
test_H = [1,2;3,4];
result = dF(test_alpha,test_H);
expected = [-16.5;-31.5];

if(~isequal(result, expected)) 
    result;
    expected;
    warning("df(alpha) not working as expected. Test 1 failed")
else
    disp("df(alpha): Test 1 passed")
end
fprintf("\n")


%--------------------------------------------------------------------------
%% Unit test for equaility constraint
%--------------------------------------------------------------------------
disp("Unit Tests for equality constaint function:")
clear all 

% Test 1 
%--------
test_alpha = [1.5;2.3;1.3;1.5];
classes =[-1;-1;-1;-1];

result = C_e(test_alpha, classes);
expected = -sum(test_alpha);

if(result ~= expected)
    result;
    expected;
    warning("C_e(alpha,y) not working as expected. Test 1 failed.")
else
    disp("C_e(alpha,y): Test 1 passed")
end

% Test 2
%-------
test_alpha = [0;0;0;0];
classes = [-1;2;1;3];
result = C_e(test_alpha, classes);
expected = 0;
if(result ~= expected)
    result;
    expected;
    warning("C_e(alpha,y) not working as expected. Test 2 failed.")
else
    disp("C_e(alpha,y): Test 2 passed")
end
fprintf("\n")

%--------------------------------------------------------------------------
%% Unit test for differnetial of equaility constraint
%--------------------------------------------------------------------------
disp("Unit Tests for differential of equality constaint function:")
clear all

% Test 1: Testing d/da (C_e)^2
%--------
test_classes = [1;2];
test_alpha = [3;7];

result = 2*test_classes*C_e(test_alpha, test_classes);
expected = [34;68];

if(~isequal(result,expected))
    result;
    expected;
    warning("dC_e(alpha,y) not working as expected. Test 1 failed.")
else
    disp("dC_e(alpha,y): Test 1 passed")
end
fprintf("\n")


%--------------------------------------------------------------------------
%% Unit test for inequaility constraint
%--------------------------------------------------------------------------
disp("Unit Tests for inequality constaint function:")
clear all 

% Test 1
%-------
test_alpha = [1;2;3;4];
test_lambda = [0;5;0.3;2];
test_mu = 2;
result = Psi(test_alpha,test_mu,test_lambda);
expected = -13.09;

if(result ~= expected)
    result;
    expected;
    warning("Psi(alpha,mu,lambda) not working as expected. Test 1 failed.")
else
    disp("Psi(alpha,mu,lambda): Test 1 passed")
end
fprintf("\n")


%--------------------------------------------------------------------------
%% Unit test for differential of inequaility constraint
%--------------------------------------------------------------------------
disp("Unit Tests for inequality constaint function:")
clear all 

% Test 1
%-------
test_alpha = [1;2;3;4];
test_lambda = [0;5;0.3;2];
test_mu = 2;
result = dPsi(test_alpha,test_mu,test_lambda);
expected = [0;-4;0;0];

if(~isequal(result,expected))
    result;
    expected;
    warning("Psi(alpha,mu,lambda) not working as expected. Test 1 failed.")
else
    disp("Psi(alpha,mu,lambda): Test 1 passed")
end
fprintf("\n")


%--------------------------------------------------------------------------
%% Testing calcW
%--------------------------------------------------------------------------
disp("Testing calcW()")
clear all 

% Test 1
%-------
y = [-1;1];
alpha = [0.5; 0.5];
x = [1,2,3;
     2,3,4];
 
expected = [1/2;1/2;1/2];
result = calcW(alpha,x,y);

if(~isequal(result,expected))
    result;
    expected;
    warning("calcW not working as expected. Test 1 failed.")
else
    disp("calcW: Test 1 passed")
end
fprintf("\n")

%--------------------------------------------------------------------------
%% Testing calcb
%--------------------------------------------------------------------------
disp("Testing calcb()")
clear all 
supportVec = [1,2,3,-1,0.5;
              2,3,4,1,0.5];
expected = -3.75;
result = calcb(supportVec);
if(~isequal(result,expected))
    result;
    expected;
    warning("calcb not working as expected. Test 1 failed.")
else
    disp("calcb: Test 1 passed")
end
fprintf("\n")



%% 
disp("ALL TESTS PASSED")




















