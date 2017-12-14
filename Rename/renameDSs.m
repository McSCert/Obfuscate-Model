function renameDSs(sys)
% RENAMEDSS Give all goto/froms generic Data Store Names. 
% Note that this changes the "DataStoreName" parameter, not the "Name" parameter.
% Does not take shadowing into account.

    datastores = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'DataStoreRead');
     for i = 1:length(datastores)
        datastorename  = get_param(datastores{i}, 'DataStoreName');
     	writes = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'DataStoreWrite', 'DataStoreName', datastorename);
        reads = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'DataStoreMemory', 'DataStoreName', datastorename);
        
        set_param(datastores{i}, 'DataStoreName', ['DataStore' num2str(i)]);   
        set_param(writes{i}, 'DataStoreName', ['DataStore' num2str(i)]);
        set_param(reads{i}, 'DataStoreName', ['DataStore' num2str(i)]);
    end
end