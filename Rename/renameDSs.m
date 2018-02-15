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
        
        for j = 1:length(writes)
            set_param(writes{j}, 'DataStoreName', ['DataStore' num2str(i)]);
        end
        for j = 1:length(reads)
            set_param(reads{j}, 'DataStoreName', ['DataStore' num2str(i)]);
        end
    end
end