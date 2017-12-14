function removeDescriptions(sys)
% REMOVEDESCRIPTIONS Remove all Description parameters in lines, blocks and
% annotations.

    all = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    all = [all; find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'annotation')];
    all = [all; find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'line')];
    for i = 1:length(all)
        set_param(all(i), 'Description', '');
    end
end
