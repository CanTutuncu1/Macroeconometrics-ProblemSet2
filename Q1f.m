% Part (f) - DF Test with Deterministic Time Trend
trend_rejections = 0; % Counter for rejections
time = (1:T)'; % Time trend variable

for i = 1:N
    % Generate data with deterministic time trend and noise
    y_trend = time + sigma * randn(T, 1); % Trend + noise
    
    % Regression for Dickey-Fuller test
    dy_trend = diff(y_trend); % First difference of y_trend
    lag_y_trend = y_trend(1:end-1); % Lagged y values
    X = [ones(T-1, 1), lag_y_trend]; % Design matrix with intercept and lag_y
    
    % OLS estimation
    b = (X' * X) \ (X' * dy_trend); % Estimate parameters [α, ρ]
    residuals = dy_trend - X * b; % Residuals from the regression
    s_e = std(residuals); % Standard deviation of residuals
    
    % Calculate t-statistic for ρ
    t_stat = b(2) / (s_e / sqrt(sum((lag_y_trend - mean(lag_y_trend)).^2)));
    
    % Count rejections for one-sided test H1: ρ < 0
    if t_stat < norminv(alpha) % One-sided critical value at 95% confidence
        trend_rejections = trend_rejections + 1;
    end
end

% Calculate rejection rate
trend_rejection_rate = trend_rejections / N;
fprintf('Rejection rate for deterministic trend at 95%% confidence: %.4f\n', trend_rejection_rate);