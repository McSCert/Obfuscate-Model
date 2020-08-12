function renameConstants(sys)
% RENAMECONSTANTS Give all constants generic names. Should be run from the root
% to avoid overlapping names.

    blocks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Constant');
    blocks = get_param(blocks, 'Handle');

    for i = 1:length(blocks)
        changed = false;

        num = 1;
        while ~changed
            try
                set_param(blocks{i}, 'Name', ['Constant' num2str(i)]);
                changed = true;
            catch
                num = num + 1;
            end
        end

        set_param(blocks{i}, 'Value', ['Constant' num2str(i)]);
        set_param(blocks{i}, 'OutDataTypeStr', 'Inherit: Inherit from ''Constant value''');

        try
            set_param(blocks{i}, 'Mask', 'off');
            set_param(blocks{i}, 'LibraryVersion', '');
        catch
        end
    end
end
