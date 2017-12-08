function removeCustomConstants(sys)
% REMOVEMASKS Reset Constants to their original state.

    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block', 'BlockType', 'Constant');
    for i = 1:length(blocks)
        set_param(blocks(i), 'ReferenceBlock', ''); % So it doesn't use ChryslerLib version
        set_param(blocks(i), 'Mask', 'off');
        set_param(blocks(i), 'MaskDisplay', '');
    end
end