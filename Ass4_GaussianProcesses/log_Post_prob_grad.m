function [logp, dlogpdtheta] = log_Post_prob_grad(theta)
    % Load Data
    load('x_15.mat');
    [~,n] = size(x15);
    
    % Random Vector Calculation
    rand_t_index = round(n*rand());
    if(rand_t_index == 0)
        rand_t_index = 1;
    end
    t = x15(:,rand_t_index);
    
    % Generating Time Stamps
    data = (0:1029)';
    [m1,~] = size(data);
    
    % Get the Kernel
    [~, Q, derivatives] = squared_expo_kernel(data,theta);
    k = Q;
    
    % Calculate Beta
    L = chol(k,'lower');
    beta = linsolve(L', linsolve(L,t));
    
    % Calculate Log Probability and Negate it
    logp = -0.5.*(t'*beta) - sum(log(diag(L))) - (m1/2).*log(2*pi);
    logp = -logp;
    
    % Differentiate log(p) with respect to log \theta
    theta_len = size(theta,2);
    invk = linsolve(L',linsolve(L,eye(m1)));
    dlogpdtheta = zeros(1,theta_len);
    for d = 1:theta_len
        dlogpdtheta(d) = 0.5.*(t'*(invk*(squeeze(derivatives(:,:,d))*(invk*t)))) - 0.5*trace((invk*squeeze(derivatives(:,:,d))));
    end
    dlogpdtheta = -dlogpdtheta;
end