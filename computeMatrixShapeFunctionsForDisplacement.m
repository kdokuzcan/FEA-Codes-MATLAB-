%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: HW 6.3. Computes a matrix of shape functions such that when
% its multiplied with matrix of nodal displacements, it calculates
% displacements at an arbitrary point.
%
% Input: type of element (typeElement), values of the shape functions
% (valuesShapeFunction) and elemental nodal coordinates
% (coordinatesNodalElemental)
%
% Output: the shape function matrix (matrixShapeFunction), [cos]*[N]*[T]
%
% References: N/A
%
% Author: Kerem Dokuzcan , Fairfax, VA, 11/18/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function matrixShapeFunctions = computeMatrixShapeFunctionsForDisplacement(...
    typeElement, valuesShapeFunction, coordinatesNodalElemental)

matrixTransformation = computeMatrixTransformationForBarElement(coordinatesNodalElemental); %cosx and y
[nDimensions,nNodes] = size(coordinatesNodalElemental);

if strcmp(typeElement,'2noded_bar') == 1
    for i = 1:nDimensions
        cosMatrix(i,1) = matrixTransformation(1,i);
        matrixShapeFunctions = cosMatrix*valuesShapeFunction'*matrixTransformation;
    end
end

if strcmp(typeElement,'quad4') == 1
    matrixShapeFunctions = zeros(nDimensions,nDimensions*nNodes);
    [Rows, Cols] = size(matrixShapeFunctions);
    z = 0;
    for k = 1:Rows
        h = 1;
        for i = 1:nDimensions:Cols
            matrixShapeFunctions(k,i+z) = valuesShapeFunction(h,1);
            h = h+1;
        end
        z = z+1;
    end
end

end