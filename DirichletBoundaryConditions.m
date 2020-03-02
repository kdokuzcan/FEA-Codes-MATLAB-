%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description:
%   This class stores and handles any information related to Dirichlet boundary conditions
%
% Methods:
%   execute info method to learn about this class
%
% References:
%
% Author: Ahmad Shahba, Columbia, MD, 10/03/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef DirichletBoundaryConditions < handle
    
    properties 
        
        mapIdBoundaryConditionToIdsDofGlobal cell
        valuesBoundaryCondition double
        
    end
    
    
    methods (Static)
        
        % Provide information about this class
        function info()
            
            disp('This class stores and handles any information related to Dirichlet boundary conditions')
            disp(' ');
            disp(' ');
            disp(' Available methods:')
            disp('       DirichletBoundaryConditions(valuesBoundaryCondition):')
            disp('           constructs the object using the column array of boundary condition values (valuesBoundaryCondition)')
            disp(' ')
            disp('       assignIdsDof(idBoundaryCondition, idsDofGlobal):')
            disp('           Assigns column array of dof ids (idsDofGlobal) to a boundary condition id (idBoundaryCondition)' )
            disp(' ')
            disp('       nTypesBoundaryCondition = getNTypesBoundaryCondition()')
            disp('           returns number of boundary condition types (nTypesBoundaryCondition)')
            disp(' ')
            disp('       valueBoundaryCondition = getValueBoundaryCondition(idBoundaryCondition)')
            disp('           returns value of boundary condition (valueBoundaryCondition) corresponding to a boundary condition (idBoundaryCondition)')
            disp(' ')
            disp('       nDofsWithBoundaryCondition = getNDofsWithBoundaryCondition(idBoundaryCondition)')
            disp('           returns number of DOFs (nDofsWithBoundaryCondition) which are assigned to a boundary condition (idBoundaryCondition)')
            disp(' ')
            disp('       idDofGlobal = getIdDofWithBoundaryCondition(idBoundaryCondition, index)')
            disp('           returns id of DOF (idDofGlobal) corresponding to the index-th DOF assigned to a boundary condition (idBoundaryCondition)')
            disp(' ')
            
        end
        
        
    end
    
    
    methods
        
        % Object constructor
        function object = DirichletBoundaryConditions(valuesBoundaryCondition)
            
            nTypesBoundaryConditions = length(valuesBoundaryCondition);
            object.mapIdBoundaryConditionToIdsDofGlobal = cell(nTypesBoundaryConditions, 1);
            object.valuesBoundaryCondition= valuesBoundaryCondition;
            
        end
        
        
        % Fills the map from boundary condition id to DOF ids
        function assignIdsDof(object, idBoundaryCondition, idsDofGlobal)
            
            % Make sure that all dof ids are positive
            assert(                                                                 ...
                all(idsDofGlobal),                                                        ...
                'Dirichlet boundary condition must be assigned to positive dof ids' ...
                )
            
            % Make sure that boundary condition id is valid
            assert(                                                        ...
                idBoundaryCondition > 0 &&                                 ...
                idBoundaryCondition <= object.getNTypesBoundaryCondition(),...
                'Dirichlet boundary condition id is not valid'             ...
                )
            
            % Add list of dof ids to the previous ids. We add the new
            % list of ids to the previous ones since two nodesets may use
            % the same boundary condition id
            
            object.mapIdBoundaryConditionToIdsDofGlobal{idBoundaryCondition} =   ...
                [object.mapIdBoundaryConditionToIdsDofGlobal{idBoundaryCondition}; idsDofGlobal];
            
        end
        
        
        % Returns number of boundary condition types
        function nTypesBoundaryCondition = getNTypesBoundaryCondition(object)
            
            nTypesBoundaryCondition = length(object.valuesBoundaryCondition);
            
        end
        
        
        % Returns value of Dirichlet condition
        function valueBoundaryCondition = getValueBoundaryCondition(object, idBoundaryCondition)
            
            assert(                                                        ...
                idBoundaryCondition > 0 &&                                 ...
                idBoundaryCondition <= object.getNTypesBoundaryCondition(),...
                'Dirichlet boundary condition id is not valid'             ...
                )
            
            valueBoundaryCondition = object.valuesBoundaryCondition(idBoundaryCondition);
            
        end
        
        % Returns number of DOFs corresponding to idBoundaryCondition
        function nDofsWithBoundaryCondition = getNDofsWithBoundaryCondition(object, idBoundaryCondition)
            
            assert(                                                        ...
                idBoundaryCondition > 0 &&                                 ...
                idBoundaryCondition <= object.getNTypesBoundaryCondition(),...
                'Dirichlet boundary condition id is not valid'             ...
                )
            
            nDofsWithBoundaryCondition = length(object.mapIdBoundaryConditionToIdsDofGlobal{idBoundaryCondition});
            
        end
        
        
        % Returns id of index-th DOF with a certain boundary condition
        function idDofGlobal = getIdDofWithBoundaryCondition(object, idBoundaryCondition, index)
            
            assert(                                                                 ...
                index > 0  &&                                                       ...
                index <= object.getNDofsWithBoundaryCondition(idBoundaryCondition), ...
                'DOF index for Dirichlet boundary condition is not valid'           ...
                )
            
            idDofGlobal = object.mapIdBoundaryConditionToIdsDofGlobal{idBoundaryCondition}(index);
            
        end
        
    end
    
end