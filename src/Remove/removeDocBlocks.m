function removeDocBlocks(sys)
% REMOVEDOCBLOCKS Remove all DocBlocks from the model.

    delete_block(find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', ...
    'block', 'BlockType', 'SubSystem', 'MaskType', 'DocBlock'));
end