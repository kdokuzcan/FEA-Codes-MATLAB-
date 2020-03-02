%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: calculates the Jacobian matrix, G matrix, and determinate of the
% Jacobian.
%
% Input: derivatives of the shape functions in the master frame
% (derivativesShapeFunctionInMasterFrame), local nodal coordinates
% (coordinatesNodalLocal), and jacobian multiplier (multiplierJacobian)
%
% Output: Jacobian matrix (matrixJacobian), G matrix (matrixG), and
% determinate of the jacobian (jacobian)
%
% References: N/A
%
% Author: Kerem Dokuzcan , Fairfax, VA, 11/18/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [matrixJacobian, matrixG, jacobian] = calculateMatricesElemental( ...
    derivativesShapeFunctionInMasterFrame, coordinatesNodalLocal, multiplierJacobian)


matrixJacobian = derivativesShapeFunctionInMasterFrame*coordinatesNodalLocal';
matrixG = inv(matrixJacobian)*derivativesShapeFunctionInMasterFrame;
jacobian = det(matrixJacobian);
if jacobian <= 0 
    error('Jacobian is either zero or negative')
end

end