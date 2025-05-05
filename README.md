# Macroeconometrics-ProblemSet2
Application of unit root testing, spurious regression, granger casuality via MATLAB. This project was prepared for a group homework assignment by me and my groupmates. 

## Features
In Q1 we conduct a unit root testing. We first compute the empirical distribution of the OLS estimator in the case of an AR(1) process with phi= 1 and T = 250. We then calculate and display percentiles of the empirical t-statistic distribution. We compute the empirical distribution of the OLS in the case of a random walk with drift and T = 250 and study the performance of the Dickey-Fuller test and later construct an F-test for the null hypothesis H0. We lastly generate from a deterministic time trend and perform a DF test using the correct distribution for the test.
In Q2 we design a Monte Carlo to show that the regression coefficient, the t-test and the R2 are meaningless in the case of a spurious regression.
In Q3 we replicate the work of Romer and Romer (2004) and run a VAR with 4 lags and test for Granger causality of the Romer and Romer shocks using 4 time series: US inflation, US unemployment, US federal funds rate, the Romer and Romer monetary policy shocks from 1969 quarter 1 to 1996 quarter 4.

# Technical Properties
Written in MATLAB R2024b Update 1
