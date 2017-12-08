function fixEnums(sys)
% FIXENUMS Change the FCA custom enums back to regular constant blocks.

    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block', 'BlockType', 'Constant');
    for i = 1:length(blocks)
        set_param(blocks(i), 'OpenFcn', '');
    end
end