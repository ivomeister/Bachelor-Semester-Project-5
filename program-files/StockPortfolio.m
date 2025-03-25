% For plotting: X axis can be set to start from 0 from Edit -> Axes Properties 
%This file in invoked from file MAIN.M

function [pf, rsk, ret] = StockPortfolio(ExpRet, CovMat, numPortfolios)
    % Stock portfolio optimization - section 2.4.3

    % ExpRet - expected return of stocks
    % CovMat - covariance matrix of stock returns
    %ExpRet = [0.15 0.2 0.08];
    %CovMat = [0.2 0.05 -0.01; ...
    %      0.05 0.3 0.015; ...
    %      -0.01 0.015 0.1];

    % Defining the portfolio object (many parameters can be set)
    port = Portfolio("AssetMean", ExpRet, "AssetCovar", CovMat);
    port = setDefaultConstraints(port);

    % each column corresponds to a portfolio, in which each cell corresponds
    % to the weight of the given portfolio
    pf = estimateFrontier(port, numPortfolios);

    % Plot the estimated frontier
    % X axis can be started from 0 from Edit -> Axes Properties 
    plotFrontier(port, numPortfolios);

    % Standard deviation and mean return of the resulting portfolios
    [rsk, ret] = estimatePortMoments(port, pf)
end
