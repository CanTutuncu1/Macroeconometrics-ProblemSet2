% Part (a) - Empirical Distribution of OLS Estimator in AR(1)
T = 250; % Number of time periods
N = 1000; % Number of simulations
phi = 1; % AR(1) coefficient
sigma = 1; % Standard deviation of innovations
beta_hat = zeros(N, 1); % Preallocate for storing OLS estimates

for i = 1:N
    epsilon = sigma * randn(T, 1); % Generate random innovations
    y = zeros(T, 1); % Initialize AR(1) series
    for t = 2:T
        y(t) = phi * y(t-1) + epsilon(t); % Generate AR(1) process
    end
    % OLS estimation of AR(1) coefficient (without intercept term)
    beta_hat(i) = y(1:T-1) \ y(2:T); % Estimate phi using OLS
end

% Plot the empirical distribution of OLS estimates
figure;
histogram(beta_hat, 30);
title('Empirical Distribution of OLS Estimator in AR(1)');
xlabel('Estimate of \phi');
ylabel('Frequency');
