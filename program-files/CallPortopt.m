% For plotting: X axis can be set to start from 0 from Edit -> Axes Properties
%This file in invoked from file MAIN.M
% Portfolio optimization with constraint matrix
function [PRoR, PRisk, PWts] = CallPortopt(NAssets, AssetMin, AssetMax, Groups, GroupMin, GroupMax, ExpRet, CovMat, numPortfolios)
    %NAssets = 5;
    %AssetMin = [0.01 0.01 0.01 0.01 0.01];
    %AssetMax = [0.35 0.3 0.3 0.4 0.5];
    %Groups = [1 1 0 0 0 ; 0 0 1 1 1];
    %GroupMin = [0.2 0.3];
    %GroupMax = [0.6 0.7];
    
    ConstrMatrix = portcons('Default', NAssets, ...
                                'AssetLims', AssetMin, AssetMax, NAssets, ...
                                'GroupLims', Groups, GroupMin, GroupMax);
    
    % ExpRet - expected return for each asset
    % CovMat - covariance matrix between each asset
    %ExpRet = [0.03 0.06 0.13 0.14 0.15];
    %CovMat = [
    %    0.01 0 0 0 0
    %    0 0.04 -0.05 0 0
    %    0 -0.05 0.30 0 0
    %    0 0 0 0.40 0.20
    %    0 0 0 0.20 0.40];
    
    % A - inequality constraints
    % b - limits
    A = ConstrMatrix(:,1:end-1);
    b = ConstrMatrix(:,end);
    
    % Defining a portfolio with the expected return, covariance matrix and
    % inequality constraints
    p = Portfolio;
    p = setAssetMoments(p, ExpRet, CovMat);
    
    % p = setDefaultConstraints(p) sets up portfolio constraints with 
    % nonnegative weights that sum to 1 for Portfolio, PortfolioCVaR, or 
    % PortfolioMAD objects. For details on the respective workflows when using 
    % these different objects, see Portfolio Object Workflow, PortfolioCVaR 
    % Object Workflow, and PortfolioMAD Object Workflow.
    
    % p = setDefaultConstraints(p,NumAssets) sets up portfolio constraints 
    % with nonnegative weights that sum to 1 with an additional option for 
    % NumAssets.
    
    %A "default" portfolio set has LowerBound = 0 and 
    % LowerBudget = UpperBudget = 1 such that a portfolio Port must satisfy 
    % sum(Port) = 1 with Port >= 0.
    
    p = setDefaultConstraints(p);
    p = setInequality(p, A, b);	
    
    % Estimate n efficient frontiers and get the weights
    PWts = estimateFrontier(p, numPortfolios);
    
    % Estimate risk (standard deviation) and return for each portfolio
    [PRisk, PRoR] = estimatePortMoments(p, PWts);
    
    % Display risk (standard deviation), return and weights
    [PRoR, PRisk]
    PWts
    
    plotFrontier(p, numPortfolios);
end