%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: Hw1 Problem 3
% 
%
% Input: the order of quadature
%
%
% Output: 2 vectors containg Gauss points and coressponding weights
% 
%
% References:
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 9/9/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  [pointsGauss, weightsGauss] = getInformationQuadratureGauss(nPointsGauss)
 
pointsGauss = zeros(nPointsGauss,1);
weightsGauss = zeros(nPointsGauss,1);

 if nPointsGauss > 2 | nPointsGauss < 0
     error('Number of points must be either 1 or 2')
 end
 if nPointsGauss == 1
     pointsGauss = 0;
     weightsGauss = 2;
    
 else
     pointsGauss(1,1) = -1/sqrt(3);
     pointsGauss(2,1) = 1/sqrt(3);
     weightsGauss(1,1) = 1;
     weightsGauss(2,1) = 1;
     
 end
 end
