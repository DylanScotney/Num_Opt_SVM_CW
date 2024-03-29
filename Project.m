%% Numerical Optimisation Project 
% Name: Dylan Scotney 
% SN: 18138211
% Submission date: 09/04/2019

% clear cache and variables 
clear cache variables
addpath Lib

%--------------------------------------------------------------------------
%% Simulating dataset 
%--------------------------------------------------------------------------
numOfPoints = 200; % code will round down if not even
theta = linspace(0, 2*pi, numOfPoints/2);
% 4th column = 0 will later be used to store mapped values from kernels
scatter_circle = @(r, noise, class) [r * cos(theta) + noise(1,:);
                                     r * sin(theta) + noise(2,:);
                                     0*theta;
                                     class*ones(1,length(theta))];

% Generate random sets with norm distribution, acts as noise on sample
data_generator = rng(0,'v5normal');
noise1 = rand(2,length(theta));
noise2 = rand(2,length(theta));

dataset_p = scatter_circle(1, noise1, 1)';
dataset_m = scatter_circle(3, noise2, -1)';
dataset = [dataset_p; dataset_m];

% Plot data
figure('name', 'Non-Linearly Seperable Data')
hold on
scatter(dataset_p(:,1), dataset_p(:,2), 'o')
scatter(dataset_m(:,1), dataset_m(:,2), '*')
title("2D data set")
legend("y_i = 1", "y_i = -1")
grid off
hold off

disp("Simulated data set.")

%--------------------------------------------------------------------------
%% Seperating dataset with kernel 
%--------------------------------------------------------------------------

% Radial Basis Kernel:
%---------------------
dataset = radialBasisKernel(dataset);

% Polynomial Kernel:
%-------------------
%dataset = polynomialKernel(dataset);


% Plot Seperated Data
%==========================================================================
split = numOfPoints/2;

figure('name', 'Radial Basis Kernel Mapping')
scatter3(dataset(1:split, 1), dataset(1:split, 2),...
         dataset(1:split,3), 'o');
hold on
scatter3(dataset(split+1:end, 1), dataset(split+1:end, 2), ...
         dataset(split+1:end,3), '*');
title("Radial Basis Kernel Mapping")
legend("y_i = 1", "y_i = -1")
hold off
%==========================================================================
disp("Seperated data with radial basis kernel.")

%--------------------------------------------------------------------------
%% Calculating Hessian of Radial Basis Kernel
%--------------------------------------------------------------------------
% Computing matrix H
H = zeros(numOfPoints,numOfPoints);
for i = 1:numOfPoints
    for j = 1:numOfPoints
        H(i,j) = dataset(i,4)*dataset(j,4)*dot(dataset(i,1:3), dataset(j,1:3));
    end
end
disp("Calculated Hessian.")

%--------------------------------------------------------------------------
%% Formulating minimisation problem
%--------------------------------------------------------------------------

group = dataset(:, 4); %classification of each point

% Define function handles for augLag and diffAugLag:
%==========================================================================
f = @(a) F(a, H);
c_e = @(a) C_e(a, group);
psi = @(a, mu_I, lambda_I) Psi(a, mu_I, lambda_I);

df = @(a) dF(a, H);
dc_e = dC_e(group);
dpsi = @ (a, mu_I, lambda_I) dPsi(a, mu_I, lambda_I);

d2f = d2F(H);
d2c_e = @(mu_e) 1/mu_e * d2C_e(group);
d2psi = @(a, mu_I, lambda_I) d2Psi(a, mu_I,  lambda_I);

%==========================================================================


% Defining Lagrangian (see report) <add more info here>
%==========================================================================
L.f = @(a, mu_e, lambda_e, mu_I, lambda_I) augLagrangian(f, c_e, psi, a,...
                                                       mu_e, lambda_e, ...
                                                       mu_I,lambda_I);

L.df = @(a, mu_e, lambda_e, mu_I, lambda_I) diffAugLagrangian(df, dc_e, c_e,...
                                                            dpsi, a, mu_e,...
                                                            lambda_e, mu_I,...
                                                            lambda_I);  
                                                        
L.d2f = @(a, mu_e, mu_I, lambda_I) d2AugLagrangian(d2f, d2c_e, d2psi, a, mu_e,...
                                             mu_I, lambda_I);
%==========================================================================

disp("Formulated minimisation problem.")

%--------------------------------------------------------------------------
%% Solving Minimisation Problem
%--------------------------------------------------------------------------

% Initialisation:
%==========================================================================
% Starting point
a0 = zeros(length(H), 1);

% Parameters
mu_e0 = 1;
lambda_e0 = 1;
mu_I0 = 1;
lambda_I0 = ones(length(H), 1);
tol = 1e-8;
alpha0 = 1;
maxIter = 500;
storeInfo = true;
dataGroups = dataset(:,4);
%==========================================================================

% Solving using Framework 17.3 from Nocedal and Wright:
%=========================================================================
[a_k, f_max, nIter, info] = augLagFramework(L, a0, dataGroups, mu_e0,...
                                            lambda_e0, mu_I0, lambda_I0,...
                                            tol, maxIter, storeInfo);
a_k;
norm(info.diff(:,end))
%==========================================================================
disp("Solving minimisation problem.")  
disp(info.stopCond)

%--------------------------------------------------------------------------
%% Plotting data of solution
%--------------------------------------------------------------------------

% Plotting paths if 2D problem: 
%==========================================================================
if(numOfPoints == 3)
    func2 = @(x,y) L.f([x;y],realmax,0,realmax,[0;0]);
    figure('name', '2d path')
    hold on 
    fcontour(func2,[0, 1.5,0,1.5], 'LevelStep', 0.01)
    plot(info.as(1,:), info.as(2,:), 'r-o', 'MarkerFaceColor', 'r')
    plot(0:0.1:1, 0:0.1:1,'b') % sum(alpha_iy_i) = 0
    hold off
end
%==========================================================================

% Plotting Convergence of a_k:
%==========================================================================
successiveDiff = [diff(info.as(1,:)); diff(info.as(2,:))];
figure('name', 'Convergence of alpha')
semilogy(vecnorm(successiveDiff, 2, 1))
xlabel("Iteration")
ylabel("||\alpha_k - \alpha_k_-_1)||")
%==========================================================================

% Plotting newt iters:
%==========================================================================
figure('name', 'newtIters')
plot(info.newtIter)
xlabel("Iteration")
ylabel("Newton method iterations")
%==========================================================================


% Plotting Parameters:
%==========================================================================
figure('name', 'lambda_I')
plot(vecnorm(info.lambda_I,2,1))
ylabel("||\lambda^I||")
xlabel("Iteration")

figure('name', 'mu_I')
semilogy(info.mu_I)
ylabel("||\mu^I||")
xlabel("Iteration")

figure('name', 'mu_e')
semilogy(info.mu_e)
ylabel("||\mu^e||")
xlabel("Iteration")

figure('name', 'lambda_e')
hold on
plot(info.lambda_e)
plot(vecnorm(info.lambda_I,2,1))
ylim([0,140])
legend("||\lambda^e||", "||\lambda^I||")
xlabel("Iteration")
%==========================================================================
disp("Plotting results")


%--------------------------------------------------------------------------
%% Calculating Equation of Plane
%--------------------------------------------------------------------------

% Calculate w = sum(alpha_i * y_i * x_i)
%==========================================================================
w = calcW(a_k, dataset);
disp("Calculating w")
%==========================================================================

% Determine Support Vectors
%==========================================================================
% Indicies for a_i > 0
supportVecs = [];
sVecsI = [];
for i = 1:length(a_k)
    if(a_k(i) > 0.01)
        % use i as supportVec
        supportVecs = [supportVecs; dataset(i,:), a_k(i)];   
        sVecsI = [sVecsI; i];
    end
end
disp("Calculating Support Vectors")
%==========================================================================

% Calculating b
%==========================================================================
b = calcb(supportVecs);
disp("calculating b")
%==========================================================================

%--------------------------------------------------------------------------
%% Plotting SVM plane
%--------------------------------------------------------------------------

func = @(x,y) (-b - w(1)*x - w(2)*y)/w(3);
[X,Y] = meshgrid(-4:0.1:4, -4:0.1:4);
Z = func(X,Y);

figure('name', 'SVM Mapping')
hold on
scatter3(dataset(1:split, 1), dataset(1:split, 2), dataset(1:split,3), 'o');
surf(X,Y,Z)
scatter3(dataset(split+1:end, 1), dataset(split+1:end, 2), dataset(split+1:end,3), '*');
scatter3(dataset(sVecsI, 1), dataset(sVecsI, 2), dataset(sVecsI,3), 'k', '*');
xlabel('x')
ylabel('y')
zlabel('z')
legend("y_i = 1", "SVM", "y_i = -1")
hold off

disp("Plotting SVM plane")

%% 

