function obfuscateModel(sys)

    % FCA specific
    % fixEnums(sys) % this is taken care of in removeBlockFunctions
    
    % Disable links
    removeLinks(sys) % Takes care of custom blocks
    
    % Delete blocks
    removeAnnotations(sys)
    removeDocBlocks(sys)
    
    % Remove parameters
    removeMasks(sys)
    removeColors(sys)
    removeBlockParams(sys)  % might affect codegen
    removeCustomDataTypes(sys) % will probably affect functionality
    removeSignalNames(sys)
    removeBlockFunctions(sys)
    removeDescriptions(sys)
    %removeModelInformation(sys) % doesnt work
    
    % Rename
    renameSubsystems(sys)
    renamePorts(sys)
    renameConstants(sys)
    renameGotoTags(sys)
    renameGotos(sys)
    renameDSs(sys)
end