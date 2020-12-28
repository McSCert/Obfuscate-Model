function obfuscateModel(sys, parentSys, varargin)
% OBFUSCATEMODEL Obfuscate a Simulink model such that application-specific or
% company-specific details are removed.
%
%   Inputs:
%       sys         Model name.
%       parentSys   Parent model name. [Optional]
%       varargin    Parameter names and values for specifying what elements of
%                   the model are affected. [Optional]
%
%   Outputs:
%       N/A
%
%   Side Effects:
%       Modified model
%
%   Example:
%       obfuscateModel(gcs, [], {'removecolorblocks', 1})
    
    % If no args are given, run all checks. 
    % If some args are given, only run those enabled.
    if isempty(varargin)
        default = 1;
    else
        default = 0;
    end
    
    if ~exist('parentSys', 'var')
        parentSys = [];
    end
    
    if strcmp(get_param(sys, 'Lock'), 'on')
        error('Model must be unlocked.');
    end
    
    %% Manage parameters
    % Simulink
    %   Remove
    removemasks             = getInput('removemasks', varargin, default);
    removelibrarylinks      = getInput('removelibrarylinks', varargin, default);
    removemodelreferences   = getInput('removemodelreferences', varargin, 0); 
    removesignalnames       = getInput('removesignalnames', varargin, default);
    removedocblocks         = getInput('removedocblocks', varargin, default);
    removeannotations       = getInput('removeannotations', varargin, default);
    removedescriptions      = getInput('removedescriptions', varargin, default);
    removeblockcallbacks    = getInput('removeblockcallbacks', varargin, default);
    removemodelinformation  = getInput('removemodelinformation', varargin, default);
    
    removecolorblocks       = getInput('removecolorblocks', varargin, default);
    removecolorannotations  = getInput('removecolorannotations', varargin, default);
    
    %   Rename
    renameblocks            = getInput('renameblocks', varargin, default); 
    renameconstants         = getInput('renameconstants', varargin, default);
    renamegotofromtag       = getInput('renamegotofromtag', varargin, default);
    renamedatastorename     = getInput('renamedatastorename', varargin, default);
    renamearguments         = getInput('renamearguments', varargin, default);
    renamefunctions         = getInput('renamefunctions', varargin, default);
    
    %   Hide
    hideblocknames          = getInput('hideblocknames', varargin, default);
    hidecontentpreview      = getInput('hidecontentpreview', varargin, default);
    hideportlabels          = getInput('hideportlabels', varargin, default);
    
    % Stateflow
    sfcharts                = getInput('sfcharts', varargin, default);
    sfports                 = getInput('sfports', varargin, default);
    sfevents                = getInput('sfevents', varargin, default);
    sfstates                = getInput('sfstates', varargin, default);
    sfboxes                 = getInput('sfboxes', varargin, default);
    
    % Recursion
    recursemodels           = getInput('recursemodels', varargin, default);
    
    %% Recurse Model References
    if ~removemodelreferences && recursemodels
        refs = find_system(sys, 'BlockType', 'ModelReference');
        if ~isempty(refs)
            for i = 1:length(refs)
                modelName = get_param(refs{i}, 'ModelName');
                load_system(modelName);
                obfuscateModel(modelName, sys, varargin{:});
                save_system(modelName);
                close_system(modelName);
                Simulink.ModelReference.refresh(refs{i});
            end
        end
    end
    
    %% Perform Obfucsation
    % Remove parameters and blocks
    if removemasks
        removeMasks(sys)
    end
    
    if removelibrarylinks
        removeLibraryLinks(sys)
    end
    
    if removemodelreferences
        removeModelReferences(sys)
    end

    if removesignalnames
        removeSignalNames(sys)
    end
    
    if removedocblocks
        removeDocBlocks(sys)
    end
    
    if removeannotations
        removeAnnotations(sys)
    end
    
    if removedescriptions
        removeDescriptions(sys)
    end

    if removecolorblocks
        removeBlockColors(sys)
    end
    
    if removecolorannotations
        removeAnnotationColors(sys)
    end

    if removeblockcallbacks
        removeBlockCallbacks(sys)
    end
    
    if removemodelinformation
        removeModelInformation(sys)
    end
    
    %removeCustomDataTypes(sys)  % will probably affect functionality

    % Rename
    if renameblocks
        renameBlocks(sys)
    end
    
    if renameconstants
        renameConstants(sys)
    end
    
    if renamegotofromtag
        renameGotoTags(sys)
    end
    
    if renamedatastorename
        renameDSs(sys)
    end
    
    if renamearguments
        renameArgs(sys, parentSys);
    end
    
    if renamefunctions
        renameSimFcns(sys, parentSys);
    end
    
    renameStateflow(sys, 'sfcharts', sfcharts, 'sfports', sfports, 'sfevents', sfevents, 'sfstates', sfstates, 'sfboxes', sfboxes);
    
    % Hide
    if hideblocknames
        hideBlockNames(sys);
    end
          
    if hidecontentpreview
        hideContentPreview(sys);
    end
    
    if hideportlabels
        hidePortLabels(sys);
    end
    
    %renameLinks(sys)
end