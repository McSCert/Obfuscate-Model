function removeMasks(sys)
% REMOVEMASKS Clear the MaskDisplay parameter on blocks. Masks are commonly
% used for custom blocks, which the user may not want to reveal.

    blocks = find_system(sys, 'FollowLinks', 'on', 'type', 'block');
    for i = 1:length(blocks)
        try
            set_param(blocks{i}, 'MaskDisplay', '');
            set_param(blocks{i}, 'Mask', 'off');
        catch
            % Skip. Reference blocks won't allow it.
        end
    end
end