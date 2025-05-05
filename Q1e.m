% Part (e) - F-test for unit root
f_rejections = 0; % Counter for F-test rejections

for i = 1:N
    % Generate AR(1) process with phi = 1 (random walk)
    epsilon = sigma * randn(T, 1);
    y = zeros(T, 1);
    for t = 2:T
        y(t) = y(t-1) + epsilon(t); % Random walk: y_t = y_{t-1} + epsilon_t
    end
    
    % Regression: ∆y_t = α + ρ * y_{t-1} + ε_t
    dy = diff(y);
    lag_y = y(1:end-1);
    X = [ones(T-1, 1), lag_y];
    b = (X' * X) \ (X' * dy);
    residuals = dy - X * b;
    
    % Calculate the F-statistic for H0: ρ = 0
    SSR = sum(residuals.^2); % Sum of squared residuals
    SST = sum((dy - mean(dy)).^2); % Total sum of squares
    F_stat = ((SST - SSR) / 1) / (SSR / (T - 2)); % F-statistic with 1 numerator df

    % Check for rejection of null hypothesis at 95% confidence level
    if F_stat > finv(1-alpha, 1, T-2) % Critical F-value from chi-square distribution
        f_rejections = f_rejections + 1;
    end
end

% Calculate rejection rate for F-test
f_rejection_rate = f_rejections / N;
fprintf('F-test rejection rate at 95%% confidence: %.4f\n', f_rejection_rate);