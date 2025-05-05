% Load the data (adjust file path if necessary)
data = readtable('Romer_Romer.xlsx'); % Ensure your file has correct column names
inflation = data{:, 'Inflation'}; % Column for inflation
unemployment = data{:, 'Unemployment'}; % Column for unemployment
fed_funds_rate = data{:, 'FederalFundsRate'}; % Column for federal funds rate
romer_shocks = data{:, 'RomerShocks'}; % Column for Romer shocks

% Combine variables into a matrix for VAR model (rows: observations, columns: variables)
Y = [inflation, unemployment, fed_funds_rate, romer_shocks];

% Specify and estimate VAR model with 4 lags
numLags = 4;
Mdl = varm(size(Y, 2), numLags); % VAR model for 4 variables with 4 lags
EstMdl = estimate(Mdl, Y); % Estimate the VAR model

% Define variable indices for clarity
romer_index = 4; % Romer shocks are the 4th variable
inflation_index = 1;
unemployment_index = 2;
fed_funds_rate_index = 3;

% Granger causality tests for Romer shocks causing other variables
[h, pValue] = grangercausality(EstMdl, romer_index, inflation_index);
fprintf('Romer shocks Granger-cause inflation: h = %d, p-value = %.4f\n', h, pValue);

[h, pValue] = grangercausality(EstMdl, romer_index, unemployment_index);
fprintf('Romer shocks Granger-cause unemployment: h = %d, p-value = %.4f\n', h, pValue);

[h, pValue] = grangercausality(EstMdl, romer_index, fed_funds_rate_index);
fprintf('Romer shocks Granger-cause federal funds rate: h = %d, p-value = %.4f\n', h, pValue);

% Granger causality tests for other variables causing Romer shocks
[h, pValue] = grangercausality(EstMdl, inflation_index, romer_index);
fprintf('Inflation Granger-causes Romer shocks: h = %d, p-value = %.4f\n', h, pValue);

[h, pValue] = grangercausality(EstMdl, unemployment_index, romer_index);
fprintf('Unemployment Granger-causes Romer shocks: h = %d, p-value = %.4f\n', h, pValue);

[h, pValue] = grangercausality(EstMdl, fed_funds_rate_index, romer_index);
fprintf('Federal funds rate Granger-causes Romer shocks: h = %d, p-value = %.4f\n', h, pValue);