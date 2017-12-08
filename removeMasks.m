function removeMasks(sys)
% REMOVEMASKS Clear the MaskDisplay param on blocks. Sometimes they reveal info.

    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    for i = 1:length(blocks)
        try
            set_param(blocks(i), 'MaskDisplay', '');
            set_param(blocks(i), 'Mask', 'off');
        catch
            % Skip if there is a problem. Linked blocks won't allow it.
        end
    end
end