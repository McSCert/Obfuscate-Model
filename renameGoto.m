function renameGoto(sys, gotoname, name)
% RENAMEGOTO Rename all gotos, froms, and goto tag visibility blocks that 
% share a GotoTag with a new GotoTag. Note that this is the "GotoTag" parameter 
% and not the "Name" parameter of the data store blocks. Does not take shadowing 
% into account.

    gotos = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Goto', 'GotoTag', gotoname);
    gotos = [gotos; find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'From', 'GotoTag', gotoname)];
    for i = 1:length(gotos)
        set_param(gotos{i}, 'GotoTag', name);
    end
end