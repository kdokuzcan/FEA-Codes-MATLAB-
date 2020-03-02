%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: places values from elemental stiffness matrix to
% corresponding position in global stiffness matrix
%
% Input: numbers of degrees of freedom (nDofs), elemental stiffness matrix
% (matrixStiffnessElemental), vector of global DOF ID's (idsDofGlobal), and
% force vector (vectorForce)
%
%
% Output: object containing global stiffness matrix (matrixStiffnessGlobal)
% and global force vector (vectorForceGlobal)
% 
%
% References:
%
%
% Author: Kerem Dokuzcan , Fairfax, VA, 10/24/2019. Updated on 10/31/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef GlobalFemSystem < handle
    properties
        matrixStiffnessGlobal 
        vectorForceGlobal
    end
    
    methods
        %Problem #2
        %constructor
        function object = GlobalFemSystem(nDofs)
            if nDofs >= 1
                object.matrixStiffnessGlobal = zeros(nDofs);
                object.vectorForceGlobal = zeros(nDofs, 1);
            else
                error('Error: Number of DOFS must be greater than or equal to 1!')
            end
            
        end
        
        %Problem #3
        %returns the global matrix stiffness
        function matrixStiffness = getMatrixStiffness(object)
            matrixStiffness = object.matrixStiffnessGlobal;
        end
        
        %Problem #4
        %returns the force vector
        function vectorForce = getVectorForce(object)
            vectorForce = object.vectorForceGlobal;
        end
        
        %Problem #5
        %
        function addMatrixStiffnessElemental(object, matrixStiffnessElemental, idsDofGlobal)
            %check if elemental stiffness matrix is square
            [nRows, nColumns] = size(matrixStiffnessElemental);
            if nRows ~= nColumns
                error('Error: elemental stiffness matrix is not square!')
            end
            %check if number of columns/rows in elemental stiffness equal
            %rows in idsDofGlobal
            if (length(idsDofGlobal) ~= nRows)||(length(idsDofGlobal) ~= nColumns)
                error('Error: number of rows in DOF IDs are not adequate');
            end
            %check if size of idsDofglobal matrix works  
            if all((idsDofGlobal >= 1)) && all((idsDofGlobal <= length(object.matrixStiffnessGlobal))) == 0
                error('Error: values of DOF IDs are not adequate');
            end
            %assemble matrix
            object.matrixStiffnessGlobal(idsDofGlobal(1:numel(idsDofGlobal)),idsDofGlobal(1:numel(idsDofGlobal))) = ... 
                matrixStiffnessElemental + object.matrixStiffnessGlobal(idsDofGlobal(1:numel(idsDofGlobal)),idsDofGlobal(1:numel(idsDofGlobal)));
            
        end
        
        %Problem #6
        %assembles any type of force vectors into the global force vector
        function addVectorForce(object, vectorForce, idsDofGlobal)
            %check to see if number of rows of vector is equal to number of
            %rows of DOF IDs
            if (length(vectorForce) ~= length(idsDofGlobal))
                error('Error: rows of force vector dont match rows of DOF IDs');
            end
            %check if size of idsDofglobal matrix works
            if all(idsDofGlobal >= 1) && all((idsDofGlobal <= length(object.vectorForceGlobal))) == 0
                error('Error: values of DOF IDs are not adequate');
            end
            
            object.vectorForceGlobal(idsDofGlobal) = vectorForce + object.vectorForceGlobal(idsDofGlobal);
        end
        
        %Updated 10/31/2019
        %Homework 5 Problem 3: Apply DBC to the global stiffness matrix and
        %vector matrix
        function imposeBoundaryConditionsDirichlet(object, dirichletBoundaryConditions)
            sizeMatrixGlobal = size(object.matrixStiffnessGlobal,1);
            kavg = trace(object.matrixStiffnessGlobal)/sizeMatrixGlobal;
            nTypesBC = dirichletBoundaryConditions.getNTypesBoundaryCondition();
            for type=1:nTypesBC
                valueBC = dirichletBoundaryConditions.getValueBoundaryCondition(type);
                diagVal = kavg*valueBC;
                for bc=1:dirichletBoundaryConditions.getNDofsWithBoundaryCondition(type)
                    gId = dirichletBoundaryConditions.getIdDofWithBoundaryCondition(type,bc);
                    object.vectorForceGlobal = object.vectorForceGlobal-object.matrixStiffnessGlobal(1:sizeMatrixGlobal,gId)*valueBC;
                    object.vectorForceGlobal(gId) = kavg*valueBC;
                    object.matrixStiffnessGlobal(1:sizeMatrixGlobal,gId)= zeros(sizeMatrixGlobal,1);
                    object.matrixStiffnessGlobal(gId,1:sizeMatrixGlobal) = zeros(1,sizeMatrixGlobal);
                    object.matrixStiffnessGlobal(gId,gId) = kavg;
                end
            end
        end
        
        %Updated 10/31/2019
        %Homework 5 Problem 4: Solve the system
        function solution = solveSystem(object)
            solution = inv(object.matrixStiffnessGlobal)*object.vectorForceGlobal;
        end
        
    end
end