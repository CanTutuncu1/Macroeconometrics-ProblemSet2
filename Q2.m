% Question 2 - Spurious Regression
N = 1000; % Number of simulations
rejections_spurious = zeros(4, 1); % For each case

for case_num = 1:4
    for i = 1:N
        % Generate two independent random walks
        x = cumsum(randn(250, 1)); % Random walk 1
        y = cumsum(randn(250, 1)); % Random walk 2
        
        % Run regression
        [b, ~, r] = regress(y, [ones(length(x), 1), x]);
        t_stat_spurious = b(2) / (std(r) / sqrt(length(x)));
        
        % Check if t-statistic is significant
        if abs(t_stat_spurious) > norminv(1 - alpha) % Two-sided test
            rejections_spurious(case_num) = rejections_spurious(case_num) + 1;
        end
    end
end

% Calculate rejection rates
rejection_rates_spurious = rejections_spurious / N;
disp('Rejection rates for spurious regression cases:');
disp(rejection_rates_spurious);