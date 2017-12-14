function renameDS(sys, datastorename, name)
% RENAMEDS Rename all data store blocks with the same data store name to a 
%   new data store name. Note that this changes the "dataStoreName" parameter,
%   not the "Name" parameter. Does not take shadowing into account.

    datastores = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'DataStoreRead', 'DataStoreName', datastorename);
    datastores = [datastores; find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'DataStoreWrite', 'DataStoreName', datastorename)];
    datastores = [datastores; find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'DataStoreMemory', 'DataStoreName', datastorename)];
    for i = 1:length(datastores)
        set_param(datastores{i}, 'DataStoreName', name);
    end
end