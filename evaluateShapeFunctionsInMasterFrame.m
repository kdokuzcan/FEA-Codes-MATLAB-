%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: HW 5.7 & 6.1 . Computes the values of shape functions in
% master (natural) coordinate system. 
%
% Input: a character array denoting the element type(typeElement), a
% nDimensionalityElement x 1 matrix storing coordinate of a point in the
% master frame (coordinatesNatural)
%
%
% Output: a nNodesPerElement x 1 matrix containing values of shape
% functions (valueShapeFunction) for 2 noded bar elements and quad 4 elements
% 
%
% References: N/A
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 11/14/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function valuesShapeFunction = evaluateShapeFunctionsInMasterFrame(typeElement, coordinatesNatural)

if strcmp(typeElement,'2noded_bar') == 1 %strcmp compares the two arguments and returns 1 if they are the same, 0 if they are different
    valuesShapeFunction(1,1) = 0.5*(1 - coordinatesNatural(1,1));
    valuesShapeFunction(2,1) = 0.5*(1 + coordinatesNatural(1,1));
   
elseif strcmp(typeElement, 'quad4') == 1
    valuesShapeFunction(1,1) = 1/4*((1 - coordinatesNatural(1,1))*(1 - coordinatesNatural(2,1)));
    valuesShapeFunction(2,1) = 1/4*((1 + coordinatesNatural(1,1))*(1 - coordinatesNatural(2,1)));
    valuesShapeFunction(3,1) = 1/4*((1 + coordinatesNatural(1,1))*(1 + coordinatesNatural(2,1)));
    valuesShapeFunction(4,1) = 1/4*((1 - coordinatesNatural(1,1))*(1 + coordinatesNatural(2,1)));

else
    error('element type is not a 2 noded bar or quad 4 element')
end
end
