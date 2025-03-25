% Can be used only for portfolio composed of 2 assets
% For plotting: X axis can be set to start from 0 from Edit -> Axes Properties
%This file in invoked from file MAIN.M


% Value at Risk computation
function var = VaR(s1, s2, rho, ExpRet, PWts, PRoR, confidenceLevel, PValue)
    % Set display format to show values in two decimal places
    format bank
    
    % Compute standard deviations for the two assets
    %s1 = 0.02 * sqrt(10);
    %s2 = 0.01 * sqrt(10);
    
    % Correlation coefficient between the two assets
    %rho = 0.7;
    
    % Covariance matrix based on standard deviations and correlation
    CovMat = [s1^2 rho*s1*s2 ; rho*s1*s2 s2^2];
    
    % Compute portfolio statistics based on weights and covariance matrix
    % [PortRisk,PortReturn] = portstats(ExpReturn,ExpCovariance) computes the 
    % expected rate of return and risk for a portfolio of assets.
    s = portstats(ExpRet, CovMat, PWts);
    
    % Compute VaR with confidence level 1% and portfolio value 10 million
    % Compute the Maximum Potential Loss in the Value of a Portfolio Over One 
    % Period of Time. It returns a positive number or 0.
    % The confidence level must be higher than 0
    var = portvrisk(PRoR,s,confidenceLevel,PValue); % Return = 0, risk = s
    var
end