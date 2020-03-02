%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: Use equation (1) displayed in the problem statement in
% Homework 3 problem 2, and execure this equation for a property of the
% material.
% 
%
% Input: propertys of 2 materials, A and B, and a volume fraction of one of
% the materials, A.
%
%
% Output: New material propertrys of the two combined materials.
% 
%
% References:
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/16/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function propertyMaterialNew = executeRuleOfMixtures(propertyMaterialA, propertryMaterialB, fractionVolumeA)

propertyMaterialNew = fractionVolumeA * propertyMaterialA + (1 - fractionVolumeA) * propertryMaterialB; %equation for Rule Of Mixtures

end
