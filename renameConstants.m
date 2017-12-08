function renameConstants(sys)
% RENAMECONSTANTS Give all constants generic names. Should be run from the root 
% to avoid overlapping names.

    blocks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Constant');
    for i = 1:length(blocks)

        set_param(blocks{i}, 'Value', ['Constant' num2str(i)]);
        set_param(blocks{i}, 'OutDataTypeStr', 'Inherit: Inherit from ''Constant value''');       
        set_param(blocks{i}, 'Name', ['Constant' num2str(i)]);
        
        try
            set_param(blocks{i}, 'Mask', 'off');
            set_param(blocks{i}, 'LibraryVersion', '');
        catch
        end
    end
end