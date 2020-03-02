%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: HW 5.8 & 6.2. Computes the values of the derivative of
% shape functions in master(natural) coordinate system.
%
% Input: a character array denoting the element type (typeElement), a
% nDimensionality x 1 matrix storing coordinate of a point in the master
% frame (coordinatesNatural).
%
%
% Output: a nDimensionalityElement x nNodesPerElement matrix containing
% values of derivative shape functions (derivativesShapeFunction) for
% 2 noded bar elements and quad 4 elements
% 
%
% References: N/A
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 11/14/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function derivativesShapeFunction = evaluateDerivativeShapeFunctionsInMasterFrame ... 
    (typeElement, coordinatesNatural)

if strcmp(typeElement,'2noded_bar') == 1 %strcmp compares the two arguments and returns 1 if they are the same, 0 if they are different
    derivativesShapeFunction(1,1) = -1/2;
    derivativesShapeFunction(1,2) = 1/2;
    
elseif strcmp(typeElement, 'quad4') == 1
    derivativesShapeFunction(1,1) = -1/4*(1 - coordinatesNatural(2,1)); % first row is derivative of shape functions w/ respect to zeta
    derivativesShapeFunction(1,2) = 1/4*(1 - coordinatesNatural(2,1));
    derivativesShapeFunction(1,3) = 1/4*(1 + coordinatesNatural(2,1));
    derivativesShapeFunction(1,4) = -1/4*(1 + coordinatesNatural(2,1));
    derivativesShapeFunction(2,1) = -1/4*(1 - coordinatesNatural(1,1)); %second row is derivative of shape functions w/ respect to eta
    derivativesShapeFunction(2,2) = -1/4*(1 + coordinatesNatural(1,1));
    derivativesShapeFunction(2,3) = 1/4*(1 + coordinatesNatural(1,1));
    derivativesShapeFunction(2,4) = 1/4*(1 - coordinatesNatural(1,1));
else
    error('element type is not a 2 noded bar or quad 4 element')
end
end
