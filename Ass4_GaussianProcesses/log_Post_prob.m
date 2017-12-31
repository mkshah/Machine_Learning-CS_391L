function [logp] = log_Post_prob(theta,data,t)
    % Get the Size
    [m1, ~] = size(data);
    
    % Get the Kernel
    [~, Q, ~] = squared_expo_kernel(data,theta);
    k = Q;
    
    % Calculate Beta
    L = chol(k,'lower');
    beta = linsolve(L', linsolve(L,t));
    
    % Calculate Posterior Probability and Negate it
    logp = -0.5.*(t'*beta) - sum(log(diag(L))) - (m1/2).*log(2*pi);
    logp = -logp;
end
