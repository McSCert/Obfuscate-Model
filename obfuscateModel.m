function obfuscateModel(sys)
    
    % Disable links
    removeLinks(sys) % Takes care of custom blocks and libraries
    
    % Delete blocks
    removeAnnotations(sys)
    removeDocBlocks(sys)
    
    % Remove parameters
    removeMasks(sys)
    removeColors(sys)
    removeBlockParams(sys)     % might affect codegen
    removeCustomDataTypes(sys) % will probably affect functionality
    removeSignalNames(sys)
    removeBlockFunctions(sys)
    removeDescriptions(sys)
    %removeModelInformation(sys) % doesnt work
    
    % Rename
    renameSubsystems(sys)
    renameStateflow(sys)
    renamePorts(sys)
    renameConstants(sys)
    renameGotoTags(sys)
    renameGotos(sys)
    renameDSs(sys)
    renameLinks(sys)
end