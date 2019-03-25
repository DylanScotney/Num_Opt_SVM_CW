%% Solving Minimisation Problem
%------------------------------

% Initialisation 
%---------------
%==========================================================================
% Starting point
a0 = zeros(length(H), 1);

% Params
mu_e0 = -0.01;
lambda_e0 = 1;
mu_I0 = -0.01;
lambda_I0 = ones(length(H), 1);
tol = 1e-10; 
alpha0 = 1;
maxIter = 100;

% Back tracking line search WC
btlsOpts.c1 = 1e-4;
btlsOpts.rho = 0.8;
%==========================================================================

% Implementation 
%---------------
%==========================================================================

% Store params
%===========================
mu_e_k = mu_e0;
info.mu_e = mu_e_k;

lambda_e_k = lambda_e0;
info.lambda_e = lambda_e_k;

mu_I_k = mu_I0;
info.mu_I = mu_I_k;

lambda_I_k = lambda_I0;
info.lambda_I = lambda_I_k;

a_k = a0;
info.as = a_k;

info.fmax = [];
%===========================

a_k_1 = a_k + 1;
stopCond = false;
nIter = 0;

while(~stopCond)
    
    % Define as minimisation problem i.e L(x) := -L(x):
    %======================================================================
    L_k.f = @(a) -L.f(a, mu_e_k, lambda_e_k, mu_I_k, lambda_I_k);
    L_k.df = @(a) -L.df(a, mu_e_k, lambda_e_k, mu_I_k, lambda_I_k);
    %======================================================================
    
    % Compute step:
    %======================================================================
    btlsFun = @(a_k, p_k, alpha0) backtracking(L_k, a_k, p_k,...
                                               alpha0, btlsOpts);    
                                           
    [a_k, ~, ~, ~] = nonlinearConjugateGradient(L_k, btlsFun, 'FR',...
                                                alpha0, a_k, tol, maxIter);
    %======================================================================
    
    if(norm(a_k_1 - a_k) < tol)
        stopCond = true;
    else
        % Update and store params:
        %==================================================================
        lambda_e_k = lambda_e_k - sum(a_k.*dataset(:,4))/mu_e_k;
        lambda_I_k = max(lambda_I_k - a_k/mu_I_k, 0);
        mu_e_k = 0.1*mu_e_k;
        mu_I_k = 0.1*mu_I_k;
        a_k_1 = a_k;
        
        storeInfo=true;
        if(storeInfo)
            info.lambda_e = [info.lambda_e lambda_e_k];
            info.lambda_I = [info.lambda_I lambda_I_k];
            info.mu_e = [info.mu_e mu_e_k];
            info.mu_I = [info.mu_I mu_I_k];
            info.as = [info.as a_k];
            info.fmax = [info.fmax L.f(a_k, realmax, 0,...
                                       realmax, zeros(length(a_k)))];
        end
        %==================================================================
        
        nIter = nIter + 1;
    end
end