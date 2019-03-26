function [a_k, f_max, nIter, info] = augLagFramework(L, a0, classification,...
                                                     mu_e0, lambda_e0,...
                                                     mu_I0, lambda_I0, tol,...
                                                     maxIter, storeInfo)

% Back tracking line search WC:
btlsOpts.c1 = 1e-4;
btlsOpts.rho = 0.8;
alpha0 = 1;

% Store params
%===========================
mu_e_k = mu_e0;
lambda_e_k = lambda_e0;
mu_I_k = mu_I0;
lambda_I_k = lambda_I0;
a_k = a0;

info.mu_e = [];
info.lambda_e = [];
info.mu_I = [];
info.lambda_I = [];
info.as = [];
info.fmax = [];
info.diff = [];
%===========================

a_k_1 = a_k + 1;
stopCond = false;
nIter = 0;

while(~stopCond)
    
    % Define as minimisation problem i.e L(x) := -L(x):
    %======================================================================
    L_k.f = @(a) L.f(a, mu_e_k, lambda_e_k, mu_I_k, lambda_I_k);
    L_k.df = @(a) L.df(a, mu_e_k, lambda_e_k, mu_I_k, lambda_I_k);
    L_k.d2f = @(a) L.d2f(a, mu_e_k, mu_I_k, lambda_I_k);
    %======================================================================
    
    % Store Params
    %======================================================================
    if(storeInfo)
            info.lambda_e = [info.lambda_e lambda_e_k];
            info.lambda_I = [info.lambda_I lambda_I_k];
            info.mu_e = [info.mu_e mu_e_k];
            info.mu_I = [info.mu_I mu_I_k];
            info.as = [info.as a_k];
            info.fmax = [info.fmax L.f(a_k, realmax, 0,...
                                       realmax, zeros(length(a_k)))];
            info.diff = [info.diff L_k.df(a_k)];
    end
    %====================================================================== 
    
    % Compute step using backtracking and newt descent:
    %======================================================================
    btlsFun = @(a_k, p_k, alpha0) backtracking(L_k, a_k, p_k,...
                                               alpha0, btlsOpts);   
    nIter     
    [a_k, ~, ~, ~] = descentLineSearch(L_k, 'newton', btlsFun, alpha0,...
                                       a_k, tol, maxIter);                                       
   
    
    %======================================================================
    
    if(norm(a_k - a_k_1)/norm(a_k_1) < tol)
        stopCond = true;
        info.stopCond = "Convergence condition satsified";
    else
        % Update params:
        %==================================================================
        lambda_e_k = lambda_e_k - sum(a_k.*classification)/mu_e_k;
        
        lambda_I_k = max(lambda_I_k - a_k/mu_I_k, 0);
        
        if(abs(mu_I_k) < realmin*10)
            % stop updating mu
        else        
            mu_e_k = 1*mu_e_k;
            mu_I_k = 0.99*mu_I_k;
        end
        
        a_k_1 = a_k;
        %========================================================
        
        nIter = nIter + 1;
        if(nIter>maxIter)
            stopCond = true;
            info.stopCond = "Max Iters Reached";
        end
        
    end
end

f_max = L.f(a_k,realmax,0,realmax,zeros(length(a_k)));
                     
end