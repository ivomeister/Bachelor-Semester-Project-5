% For plotting: X axis can be set to start from 0 from Edit -> Axes Properties 
%This file in invoked from file MAIN.M
% Portfolio optimization with a risky asset and risk-free asset
function [PRisk, PRoR, PWts] = CallPortAllocWithRiskFree(ExpRet, CovMat, RisklessRate, BorrowRate, RiskAversion)

% ExpRet - expected return for risky assets
% CovMat - covariance matrix for risky assets
% RisklessRate - risk-free rate
% BorrowRate - borrowing rate
% RiskAversion - level of risk aversion
%ExpRet = [0.18 0.25 0.2];
%CovMat = [0.2 0.05 -0.01 ; 0.05 0.3 0.015 ; -0.01 0.015 0.1];
%RisklessRate = 0.15;
%BorrowRate = NaN;
%RiskAversion = 2; %Coefficient of investor's degree of risk aversion, 
% specified as a scalar numeric. Higher numbers indicate greater risk 
% aversion. Typical coefficients range from 2.0 through 4.0. The default 
% value of RiskAversion is 3.

% Performing portfolio optimization to get risk, return and weights for
% risky assets
[PRisk, PRoR, PWts] = portopt(ExpRet, CovMat);

% Allocating investment between risky and risk-free assets
portalloc(PRisk, PRoR, PWts, ...
        RisklessRate, BorrowRate, RiskAversion)

% Matrix to show allocation proportions
% AssetAllocation = [1-RiskyFraction, RiskyFraction*RiskyWts]