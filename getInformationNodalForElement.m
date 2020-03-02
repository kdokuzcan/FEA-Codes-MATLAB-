%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: HW 5 problem 5. function getInformationNodalForElement
% returns specific information about an element with id idElement. Look at
% inputs and outputs for more detail.
%
% Input: element id (idElement), connectivity table (connectivity), number
% of DOFS per node (nDofsPerNode), and a matrix that stores coordinates of
% all the nodes in the structure (coordinatesNodal)
%
%
% Output: a nNodesPerElement x 1 matrix containing node ids of the element
% (idsNodeLocal), a nDofsPerElement x 1 matrix containing global DOFs
% related to the element (MapIdsDofLocalToIdsDofGlobal), and a nDimensions
% x nNodesPerElement matrix storing the coordinates of nodes of an element
% (coordinatesNodealLocal).
% 
%
% References: N/A
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/31/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [idsNodeLocal, mapsIdsDofLocalToIdsDofGlobal, coordinatesNodalLocal] = ... 
    getInformationNodalForElement(idElement, connectivity, nDofsPerNode, coordinatesNodal)

[conRows,conCols] = size(connectivity);
idsNodeLocal = connectivity(1:conRows,idElement);
[dimensions,~] = size(coordinatesNodal);
mapsIdsDofLocalToIdsDofGlobal = [];
coordinatesNodalLocal = [];
for index = 1: numel(idsNodeLocal)
    for i = 1: nDofsPerNode
        idDofGlobal = (idsNodeLocal(index)-1)*nDofsPerNode + i;
        mapsIdsDofLocalToIdsDofGlobal = [mapsIdsDofLocalToIdsDofGlobal; idDofGlobal];
    end
    for i = 1: dimensions
        coord = coordinatesNodal(i,idsNodeLocal(index));
        coordinatesNodalLocal(i,index) = coord;
    end
end
end
