%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: Calculates all the properties of the two material
% structures, which contains Young's modulus (modulusYoung), Poisson's ratio (ratioPoisson),
% heat conduction coeffcient (coeffcientConductionHeat), mass density (densityMass)
% and thermal expansion coecient (coeffcientExpansionThermal), and then
% outputs the new material in a structure with the same field names.
% 
%
% Input: parameters of material A and B
%
%
% Output: new material parameters of material A and B mixed at a certain
% volume fraction
% 
%
% References:
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/16/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function parametersMaterialFG = calculatePropertiesFG(parametersMaterialA, parametersMaterialB, fractionVolumeA)

nameMaterialFG = strcat(parametersMaterialA.nameMaterial, parametersMaterialB.nameMaterial); 
modulusYoungFG = executeRuleOfMixtures(parametersMaterialA.modulusYoung, parametersMaterialB.modulusYoung, fractionVolumeA);
ratioPoissonFG = executeRuleOfMixtures(parametersMaterialA.ratioPoisson, parametersMaterialB.ratioPoisson, fractionVolumeA);
coefficentConductionHeatFG = executeRuleOfMixtures(parametersMaterialA.coefficentConductionHeat, parametersMaterialB.coefficentConductionHeat, fractionVolumeA);
densityMassFG = executeRuleOfMixtures(parametersMaterialA.densityMass, parametersMaterialB.densityMass, fractionVolumeA);
coefficentExpansionThermalFG = executeRuleOfMixtures(parametersMaterialA.coefficentExpansionThermal, parametersMaterialB.coefficentExpansionThermal, fractionVolumeA);  
%the equations above use the Rule Of Mixtures (ROM) for all properties of
%materials A and B, with the exception of the name of the materials. 

parametersMaterialFG = createMaterial(nameMaterialFG, modulusYoungFG, ratioPoissonFG, coefficentConductionHeatFG, densityMassFG, coefficentExpansionThermalFG);

end


