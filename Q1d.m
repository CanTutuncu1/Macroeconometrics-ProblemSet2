% Part (d) - Random Walk with Drift and Dickey-Fuller Test Performance
drift = 0.1; % Drift parameter
rejections_rw = 0; % Counter for rejections under the null hypothesis
t_stats_rw = zeros(N, 1); % Preallocate for storing t-test statistics

for i = 1:N
    % Generate random walk with drift
    epsilon = sigma * randn(T, 1); % Random innovations
    y = zeros(T, 1);
    for t = 2:T
        y(t) = y(t-1) + drift + epsilon(t); % Random walk with drift
    end
    
    % Regression for Dickey-Fuller test on random walk with drift
    dy = diff(y); % First difference of y
    lag_y = y(1:end-1); % Lagged values of y
    X = [ones(T-1, 1), lag_y]; % Design matrix with intercept and lag_y
    
    % OLS estimation
    b = (X' * X) \ (X' * dy); % Estimate parameters [α, ρ]
    residuals = dy - X * b; % Residuals from the regression
    s_e = std(residuals); % Standard error of residuals
    
    % Calculate t-statistic for ρ
    t_stat = b(2) / (s_e / sqrt(sum((lag_y - mean(lag_y)).^2)));
    t_stats_rw(i) = t_stat; % Store t-statistic
    
    % Check for rejection of null hypothesis
    if t_stat < norminv(alpha) % One-sided test at 95% confidence
        rejections_rw = rejections_rw + 1;
    end
end

% Calculate rejection rate for random walk with drift
rejection_rate_rw = rejections_rw / N;
fprintf('Rejection rate for random walk with drift at 95%% confidence: %.4f\n', rejection_rate_rw);

% Plot the distribution of t-statistics for random walk with drift
figure;
histogram(t_stats_rw, 30);
title('Distribution of T-test Statistics for Random Walk with Drift');
xlabel('t-statistic');
ylabel('Frequency');