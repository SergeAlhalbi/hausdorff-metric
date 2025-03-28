function [hDist, distances] = Hausdorff( gtIm, predIm )
%
% [hDist, distances] = Hausdorff( gtIm, predIm )
%
% Hausdorff finds the Hausdorff distance between a predicted image and an actual one.
%
% INPUTS:
%
%  gtIm - The actual image
%         Type: matrix
%         Class: logical
%
%  predIm - The predicted image
%           Type: matrix
%           Class: logical
%
% OUTPUTS:
%
%  hDist - The Hausdorff distance
%          Type: scalar
%          Class: single, double, etc.
%
%  distances - The distance matrix showing the distances from each positive predicted value
%          Type: matrix
%          Class: single, double, etc.

%% Defining the parameters
% Defining the dimensions
hP = size(predIm,1);
wP = size(predIm,2);
hG = size(gtIm,1);
wG = size(gtIm,2);

% Calculating the number of positive predicted and actual values
predOnes = sum(predIm(:));
actOnes = sum(gtIm(:));

% Defining a distance matrix showing the distances from each positive predicted value
distances = nan(predOnes, numel(gtIm));
distances = distances(:); % Reshaping for a convenient indexing throughout the iterations

%% Warnings
% If there is no positive predictive values
if predOnes == 0
    
    warning('No positive predictive values');
    hDist = nan; distances = nan;
    return
    
end

% If there is no positive actual values
if actOnes == 0
    
    warning('No positive actual values');
    hDist = nan; distances = nan;
    return
    
end

%% Calculating the distances
% Starting with the first element in the distances matrix
distanceElement = 1;

% Looping over the rows in the predicted image
for rowP = 1:hP
    
    % Looping over the columns in the predicted image
    for colP = 1:wP
        
        % Checking if there's a positive prediction
        if predIm(rowP,colP) == 1;
        
            % Looping over the rows in the ground truth image
            for rowG = 1:hG
            
                % Looping over the columns in the ground truth image
                for colG = 1:wG
                
                    % Checking if the positive predicted value is equal to the actual one
                    if predIm(rowP, colP) == gtIm(rowG, colG)
                        
                        % Evaluating the distance of the current iteration
                        distances(distanceElement) = sqrt((colP - colG)^2 + (rowP - rowG)^2);
                        distanceElement = distanceElement + 1;
                        
                    else
                        
                        % Skip the distance from a positive predicted value to a negative actual one
                        distanceElement = distanceElement + 1;
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

% Reshaping back to the original shape of the distances matrix
distances = reshape(distances, [numel(gtIm), predOnes]);
distances = distances';

% Finding the minimum distance from each positive predicted value to each actual one 
minDistances = min(distances, [], 2);

% Finding the maximum value among all positive predicted values
hDist = max(minDistances);

return