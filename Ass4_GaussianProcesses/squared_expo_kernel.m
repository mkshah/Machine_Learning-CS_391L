function [k1, Q1, deriv] = squared_expo_kernel(x,theta)
    % Calculate Exponential
    e_theta = exp(theta);
    [Dim, no_samples] = size(x);
    
    % Calculate Sum variable and take Norm
    sum_x_y = zeros(Dim,Dim);
    for d = 1:no_samples
         sum_x_y = sum_x_y + (repmat(x(:,d),1,Dim)-repmat(x(:,d)',Dim,1)).^2.*e_theta(2);
    end
    norm(sum_x_y);
    
    % Calculate First Term
    k1 = e_theta(1)*exp(-0.5*sum_x_y);
    norm(k1);
    
    % Add Second Term and take Norm
    Q1 = k1 + e_theta(3)*eye(Dim); 
    norm(Q1);
    
    % Calculate Partial Derivatives with respect to Hyper parameters
    deriv = zeros(Dim,Dim,3);
	deriv(:,:,1) = k1; 
	deriv(:,:,2) = -0.5*k1*sum_x_y;
    deriv(:,:,3) = e_theta(3)*eye(Dim);
end