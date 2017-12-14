function renameSubsystems(sys)
% RENAMESUBSYSTEMS Give all subsystems generic names. Should be run from the
% root.
    allBlks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'SubSystem');
    for i = length(allBlks):-1:1 % Need to go backwards, otherwise allBlks will be not up to date
        set_param(allBlks{i}, 'Name', ['Subsystem' num2str(i)]);
    end
end