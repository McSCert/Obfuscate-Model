function obfuscateModel(sys)

    % FCA specific
    fixEnums(sys)
    
    % Delete blocks
    removeAnnotations(sys)
    removeDocBlocks(sys)
    
    % Remove other
    removeBlockColors(sys)
    removeBlockParams(sys)  % might affect codegen
    removeCustomDataTypes(sys) % will probably affect functionality
    removeMasks(sys)
    removeSignalNames(sys)
    %removeModelInformation(sys) % doesnt work
    
    % Rename
    renameSubsystems(sys)
    renamePorts(sys)
    renameConstants(sys)
    renameGotoTags(sys)
    renameGotos(sys)
    renameDSs(sys)
end