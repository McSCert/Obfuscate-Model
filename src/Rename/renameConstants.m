function renameConstants(sys)
% RENAMECONSTANTS Give all constants generic values.

    blocks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Constant');
    blocks = get_param(blocks, 'Handle');

    for i = 1:length(blocks)
        set_param(blocks{i}, 'Value', ['Constant' num2str(i)]);
        set_param(blocks{i}, 'OutDataTypeStr', 'Inherit: Inherit from ''Constant value''');

        try
            set_param(blocks{i}, 'Mask', 'off');
            set_param(blocks{i}, 'LibraryVersion', '');
        catch
        end
    end
end
