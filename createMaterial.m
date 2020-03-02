%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: receive a material name (nameMaterial) and some its properties as input. The mate-
% rial properties are: Young's modulus (modulusYoung), Poisson's ratio (ratioPoisson),
% heat conduction coeffcient (coeffcientConductionHeat), mass density (densityMass)
% and thermal expansion coecient (coeffcientExpansionThermal), and outputs
% it as a strucure with fields of each property.
%
%
% Input: material name, youngs modulus, possions ratio, head conduction
% coeff. mass density, thermal expansion coeff.
%
%
% Output: outputs all of the inputs to a structure
% 
%
% References:
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/16/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function parametersMaterial = createMaterial(nameMaterial, modulusYoung, ratioPoisson, coefficientConductionHeat, ... 
                                      densityMass, coefficientExpansionThermal)

parametersMaterial = struct('nameMaterial', nameMaterial, 'modulusYoung', modulusYoung, ...                 %%parametersMaterial is a structure that has field of nameMaterial, modulusYoung... etc
                    'ratioPoisson', ratioPoisson, 'coefficentConductionHeat', coefficientConductionHeat, ...  %MUST INSERT nameMaterial VALUE IN "", NOT ''
                    'densityMass', densityMass, 'coefficentExpansionThermal', coefficientExpansionThermal);

end
