% Load the Required Configuration
load('x_15.mat');
[m,n]=size(x15);

% Calculate the mean
mean1 = mean(x15,2);

% Generate 1030 Time Stamps
time_axis = (0:1029)';

% Initialize the hyper parameters
theta_value = [0.50,0.250,0.10]; 

% Get Kernel
[K, Q, deriv]=squared_expo_kernel(time_axis,theta_value);

% Get the random vector for which loss has to be calculated
rng(1);
random_index_time = round(n*rand());
if(random_index_time == 0)
    random_index_time =1;
end
time_stamps=x15(:,random_index_time);

% Calculate Posterior Log Probability
log = log_Post_prob(theta_value,time_axis,time_stamps);

% Call the Optimizer
options = optimset('Algorithm','trust-region-reflective', 'Display','final');
function_ = @log_Post_prob_grad;
rng(1);
newTheta = fminunc(function_,theta_value,options);

% New Values
new_logp = log_Post_prob(newTheta,time_axis,time_stamps);
[Knew, Qnew, deriv_new] = squared_expo_kernel(time_axis,newTheta);
rand_vec = randn(1030,1);
F1 = chol(Q)'*rand_vec;
F = chol(Qnew)'*rand_vec + mean1 ;

% Plotting the Output
figure(1);
hold on;
plot(time_axis, x15, 'r');
plot(time_axis, F,'b','LineWidth', 2);
xlabel('Time');
ylabel('Configuration (x,15)')
hold off;