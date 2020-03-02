%
% *************************************************************************
%
%  Description:   This function checks for the equality of two
%       vectors/matrices based on a relative componentwise criterion
%
%       Inputs:
%
%
%      Outputs:
%
%      Details:
%
%   References:
%
%     Creation:   Ahmad Shahba, George Weber | 2016/2/2 | Baltimore, MD
%
% *************************************************************************

function areEqual = checkEqualityRelative(                      ...
    valuesOld,                                                  ...
    valuesNew,                                                  ...
    toleranceRelative,                                          ...
    fractionRelevance)

% Initialize required variables
PRECISION_MACHINE = 1.0e-16;
areEqual = false;
if ~exist('fractionRelevance', 'var')
    fractionRelevance = 1.0d-4;
end

assert(numel(valuesOld) == numel(valuesNew), 'checkEqualityRelative: detected inconsistent size');

% Find maximum values in old and new arrays
valueOldMaximum = abs(valuesOld(1));
valueNewMaximum = abs(valuesNew(1));
for item = 2 : numel(valuesOld)
    valueOldMaximum = max(valueOldMaximum, abs(valuesOld(item)));
    valueNewMaximum = max(valueNewMaximum, abs(valuesNew(item)));
end



%  ------------------------------------------------------------------------------------------------
%  Checking for componentwise convergence ---------------------------------------------------------
%  ------------------------------------------------------------------------------------------------

for ii = 1 : numel(valuesOld)
    
    
    changeRelativeToNew = abs( (valuesNew(ii) - valuesOld(ii)) / valuesNew(ii));
    changeRelativeToOld = abs( (valuesNew(ii) - valuesOld(ii)) / valuesOld(ii));
    
    %  Check if it is required to check the convergence criterion for this component at all. If the old
    %  component is negligibly small compared to the other old components AND the corresponding new component
    %  is also negligibly small compared to the other new components, we deem this component as-converged and
    %  it is not required to check the relative convergence criterion for this component.
    
    isRelevantComponent = ( (abs(valuesOld(ii)) >= PRECISION_MACHINE * valueOldMaximum) ||    ...
        (abs(valuesNew(ii)) >= PRECISION_MACHINE * valueNewMaximum)  );
    
    
    %  Check if the old and new components are zero. If the component is relatively close to zero, then
    %  the relative change becomes infinite.
    
    isZeroComponentOld = ~isfinite(changeRelativeToOld);
    isZeroComponentNew = ~isfinite(changeRelativeToNew);
    
    %  Check if the relative change is less equal than the relative tolerance w.r.t. old values
    if ( abs(valuesOld(ii)) >= (fractionRelevance * valueOldMaximum) )
        
        toleranceRelativeComponent = toleranceRelative ;
        
    else
        
        toleranceRelativeComponent = abs(valueOldMaximum * fractionRelevance / valuesOld(ii)) *  ...
            toleranceRelative;
        
    end
    
    isConvergedRelativeToOld = (changeRelativeToOld <= toleranceRelativeComponent);
    
    %  Check if the relative change is less equal than the relative tolerance w.r.t. new values
    if ( abs(valuesNew(ii)) >= (fractionRelevance * valueNewMaximum) )
        
        toleranceRelativeComponent = toleranceRelative ;
        
    else
        
        toleranceRelativeComponent = abs(valueNewMaximum * fractionRelevance / valuesNew(ii)) *  ...
            toleranceRelative;
    end
    
    isConvergedRelativeToNew = (changeRelativeToNew <= toleranceRelativeComponent);
    
    %  ------------------------------------------------------------------------------------------------
    %  Determine whether the component has converged   ------------------------------------------------
    %  ------------------------------------------------------------------------------------------------
    if (~isRelevantComponent)
        continue;
    end
    
    if (isRelevantComponent && ~isZeroComponentOld && isConvergedRelativeToOld)
        continue;
    end
    
    if (isRelevantComponent && isZeroComponentOld && ~isZeroComponentNew && isConvergedRelativeToNew)
        continue;
    end
    
    if (isRelevantComponent && isZeroComponentOld && isZeroComponentNew)
        continue;
    end
    
    
    return
    
end


areEqual = true;


end