% For plotting: X axis can be set to start from 0 from Edit -> Axes Properties
%This file in invoked from file MAIN.M
function ConstrMatrix = CallPortcons(NAssets, AssetMin, AssetMax, Groups, GroupMin, GroupMax)
    % Function to create a constraint matrix for portfolio optimization

    % NAssets - number of assets
    % AssetMin - minimum constraint for assets
    % AssetMax - maximum constraints for each asset
    % Groups - matrix of the group membership of each asset
    % GroupMin - minimum constraints for the groups
    % GroupMax - maximum constraints for the groups
    
    % Groups (required). NGROUPS-by-NASSETS matrix specifying which assets 
    % belong to each group.
    
    % GroupMin (required). Scalar or a vector of length NGROUPS, specifying 
    % minimum combined allocations in each group.
    
    % GroupMax (required). Scalar or a vector of length NGROUPS, specifying 
    % maximum combined allocations in each group.

    %NAssets = 5;
    %AssetMin = [0.01 0.01 0.01 0.01 0.01];
    %AssetMax = [0.35 0.3 0.3 0.4 0.5];
    %Groups = [1 1 0 0 0 ; 0 0 1 1 1];
    %GroupMin = [0.2 0.3];
    %GroupMax = [0.6 0.7];

    % Create constraint matrix using the above values as parameters

    % ConSet = portcons(ConstType,consttype_values) generates a matrix of 
    % constraints, using linear inequalities, for a portfolio of asset 
    % investments. The inequalities are of the type A*Wts' <= b, where Wts is 
    % the matrix of weights. The matrix ConSet is defined as ConSet = [A b].
    
    % https://nl.mathworks.com/help/finance/portcons.html
    ConstrMatrix = portcons('Default', NAssets, ...
                            'AssetLims', AssetMin, AssetMax, NAssets, ...
                            'GroupLims', Groups, GroupMin, GroupMax)
end