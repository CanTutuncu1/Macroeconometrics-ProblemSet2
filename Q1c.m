% Part (c) - Calculate and display percentiles of the empirical t-statistic distribution
percentiles = prctile(t_stats, [5, 10, 90]); % 5th, 10th, and 90th percentiles
disp('Empirical percentiles of the t-test statistics:');
disp(percentiles);