%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: HW 5 Problem 6. Returns the transformation matrix, given
% coordinates of nodes of an element
%
% Input: coordinates of nodes of an element (coordinatesNodalLocal)
%
%
% Output: computes and returns the transformation matrix
% (matrixTransformation)
% 
%
% References: N/A
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/31/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function matrixTransformation = computeMatrixTransformationForBarElement(coordinatesNodalLocal)

[Row,Col] = size(coordinatesNodalLocal);
    differences = []; 
    distances = []; 
    for row = 1: Row
        for col = 1:(Col -1)
            diff = coordinatesNodalLocal(row,col+1) - coordinatesNodalLocal(row,col);
            differences = [differences diff];
            distances = [distances diff^2];
        end
    end
    length = sqrt(sum(distances));
    matrixTransformation = zeros(2,numel(differences)*2);
    for index = 1: numel(differences)
        matrixTransformation(1,index) = differences(index)/length;
        matrixTransformation(2,index+numel(differences)) = differences(index)/length;
    end
end