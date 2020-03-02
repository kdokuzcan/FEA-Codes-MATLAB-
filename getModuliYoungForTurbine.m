%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: input of a cell containing two sturctures, and outputs a 2x1
% vector of the Young Modulus' contained within each strucute.
%
%
% Input: cell with two structures in it
%
%
% Output: a vector of each materials youngs modulus
% 
%
% References:
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/16/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function moduliYoungForTurbine = getModuliYoungForTurbine(propertiesMaterialForTurbine)

moduliYoungForTurbine = [propertiesMaterialForTurbine{1,1}.modulusYoung; propertiesMaterialForTurbine{1,2}.modulusYoung]; %takes in a 1x2 cell and exports a 2x1 vector

end
