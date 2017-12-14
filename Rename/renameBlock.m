function renameBlock(sys, name, newname)
% RENAMEBLOCK Rename all blocks in a model with the same name to a new name.

    blocks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Name', name);
    for i = 1:length(blocks)
        set_param(blocks{i}, 'Name', newname);
    end
end