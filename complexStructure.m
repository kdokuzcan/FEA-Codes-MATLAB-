%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: Solves a 2D 5 node, 7 element problem givin in midterm exam
%
% Input: connectivity table (2x7), number of DOFS per node (2), number of 
%        nodes (5), nodal coordinates (2x5),material properties (E), 
%        cross-sectional area (A), length of each element, Forces for each
%        node, DBC for each node
%
% Output: x and y displacements at each node, 10 total displacements
% 
%
% References:
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/24/2019. Updated on 11/7/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Input of connectivity and coordinates
connectivity = [1 4 3 2 2 1 2; 4 5 5 4 5 2 3];
nDofsPerNode = 2;
nNodes = 5;
coordinatesNodal = [0 3 6 0 6; 0 0 0 4 4];

%Find information for each node
[idsNodeLocalElement1, mapIdsDofLocalToIdsDofGlobalElement1, coordinatesNodalLocalElement1] = ...
   getInformationNodalForElement(1, connectivity, nDofsPerNode, coordinatesNodal);
[idsNodeLocalElement2, mapIdsDofLocalToIdsDofGlobalElement2,  coordinatesNodalLocalElement2] = ...
   getInformationNodalForElement(2, connectivity, nDofsPerNode, coordinatesNodal);
[idsNodeLocalElement3, mapIdsDofLocalToIdsDofGlobalElement3,  coordinatesNodalLocalElement3] = ...
   getInformationNodalForElement(3, connectivity, nDofsPerNode, coordinatesNodal);
[idsNodeLocalElement4, mapIdsDofLocalToIdsDofGlobalElement4,  coordinatesNodalLocalElement4] = ...
   getInformationNodalForElement(4, connectivity, nDofsPerNode, coordinatesNodal);
[idsNodeLocalElement5, mapIdsDofLocalToIdsDofGlobalElement5,  coordinatesNodalLocalElement5] = ...
   getInformationNodalForElement(5, connectivity, nDofsPerNode, coordinatesNodal);
[idsNodeLocalElement6, mapIdsDofLocalToIdsDofGlobalElement6,  coordinatesNodalLocalElement6] = ...
   getInformationNodalForElement(6, connectivity, nDofsPerNode, coordinatesNodal);
[idsNodeLocalElement7, mapIdsDofLocalToIdsDofGlobalElement7,  coordinatesNodalLocalElement7] = ...
   getInformationNodalForElement(7, connectivity, nDofsPerNode, coordinatesNodal);

%Compute the transformation matrix for each element
matrixTransformationElement1 = computeMatrixTransformationForBarElement(coordinatesNodalLocalElement1);
matrixTransformationElement2 = computeMatrixTransformationForBarElement(coordinatesNodalLocalElement2);
matrixTransformationElement3 = computeMatrixTransformationForBarElement(coordinatesNodalLocalElement3);
matrixTransformationElement4 = computeMatrixTransformationForBarElement(coordinatesNodalLocalElement4);
matrixTransformationElement5 = computeMatrixTransformationForBarElement(coordinatesNodalLocalElement5);
matrixTransformationElement6 = computeMatrixTransformationForBarElement(coordinatesNodalLocalElement6);
matrixTransformationElement7 = computeMatrixTransformationForBarElement(coordinatesNodalLocalElement7);

%Input E, A, and lengths
E = 200e9;
A = 0.01;
lVertical = 4;
lHorizontal = 3;
lLongHorizontal = 6;
lHypotenuse = 5;

%Solve for kHat
kVertical = (E*A/lVertical)*[1 -1; -1 1];
kHorizontal = (E*A/lHorizontal)*[1 -1; -1 1];
kLongHorizontal = (E*A/lLongHorizontal)*[1 -1; -1 1];
kHypotenuse = (E*A/lHypotenuse)*[1 -1; -1 1];

%Compute matrix stiffness for each element
matrixStiffnessElement1 = matrixTransformationElement1' * kVertical * matrixTransformationElement1;
matrixStiffnessElement2 = matrixTransformationElement2' * kLongHorizontal * matrixTransformationElement2;
matrixStiffnessElement3 = matrixTransformationElement3' * kVertical * matrixTransformationElement3;
matrixStiffnessElement4 = matrixTransformationElement4' * kHypotenuse * matrixTransformationElement4;
matrixStiffnessElement5 = matrixTransformationElement5' * kHypotenuse * matrixTransformationElement5;
matrixStiffnessElement6 = matrixTransformationElement6' * kHorizontal * matrixTransformationElement6;
matrixStiffnessElement7 = matrixTransformationElement7' * kHorizontal * matrixTransformationElement7;

%Assemble the structure
Structure = GlobalFemSystem(nNodes*nDofsPerNode); %5 nodes X 2 displacements per node (x,y) = 10 possible displacements

%Collect all elemental stiffnesses and compute global stiffness matrix
Structure.addMatrixStiffnessElemental(matrixStiffnessElement1,mapIdsDofLocalToIdsDofGlobalElement1);
Structure.addMatrixStiffnessElemental(matrixStiffnessElement2,mapIdsDofLocalToIdsDofGlobalElement2);
Structure.addMatrixStiffnessElemental(matrixStiffnessElement3,mapIdsDofLocalToIdsDofGlobalElement3);
Structure.addMatrixStiffnessElemental(matrixStiffnessElement4,mapIdsDofLocalToIdsDofGlobalElement4);
Structure.addMatrixStiffnessElemental(matrixStiffnessElement5,mapIdsDofLocalToIdsDofGlobalElement5);
Structure.addMatrixStiffnessElemental(matrixStiffnessElement6,mapIdsDofLocalToIdsDofGlobalElement6);
Structure.addMatrixStiffnessElemental(matrixStiffnessElement7,mapIdsDofLocalToIdsDofGlobalElement7);

%Assemble the forces corresponding to each node
Structure.addVectorForce([0;0;30e3;-20e3], mapIdsDofLocalToIdsDofGlobalElement1) %30kN at node 7, -20kN at node 8
Structure.addVectorForce([0;0;10e3;0], mapIdsDofLocalToIdsDofGlobalElement3) %10kN at node 9

%Apply DBC to all necessary nodes
dbc = DirichletBoundaryConditions([0]); %0 is the only known displacement
dbc.assignIdsDof(1,[1;2;5;6]); %DBC #1,[0], is applied to nodes 1, 2, 5, 6

%Apply DBC to global stiffness matrix and force vector
Structure.imposeBoundaryConditionsDirichlet(dbc);

%Solve for the displacements
displacements = Structure.solveSystem();