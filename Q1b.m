% Part (b) - T-test for unit root in an AR(1) process
T = 250; % Number of time periods
N = 1000; % Number of simulations
alpha = 0.05; % Significance level for 95% confidence
sigma = 1; % Standard deviation of innovations
rejections = 0; % Counter for rejections of H0
t_stats = zeros(N, 1); % Preallocate for storing t-test statistics

for i = 1:N
    % Generate AR(1) process with phi = 1 (random walk)
    epsilon = sigma * randn(T, 1); % Random innovations
    y = zeros(T, 1); % Initialize series
    for t = 2:T
        y(t) = y(t-1) + epsilon(t); % Random walk: y_t = y_{t-1} + epsilon_t
    end
    
    % Regression: ∆y_t = α + ρ * y_{t-1} + ε_t
    dy = diff(y); % First difference of y
    lag_y = y(1:end-1); % Lagged values of y
    X = [ones(T-1, 1), lag_y]; % Design matrix with intercept and lag_y
    
    % OLS estimation
    b = (X' * X) \ (X' * dy); % Estimate parameters [α, ρ]
    residuals = dy - X * b; % Residuals from the regression
    s_e = std(residuals); % Standard deviation of residuals
    
    % Calculate t-statistic for ρ (b(2) is the estimate of ρ)
    t_stat = b(2) / (s_e / sqrt(sum((lag_y - mean(lag_y)).^2))); 
    t_stats(i) = t_stat; % Store t-statistic

    % Count rejections for one-sided test H1: ρ < 0
    if t_stat < norminv(alpha) % Using the normal distribution for 95% confidence
        rejections = rejections + 1;
    end
end

% Calculate rejection rate
rejection_rate = rejections / N;
fprintf('Rejection rate at 95%% confidence level: %.4f\n', rejection_rate);

% Plot the distribution of t-statistics
figure;
histogram(t_stats, 30);
title('Distribution of T-test Statistics for ρ');
xlabel('t-statistic');
ylabel('Frequency');
