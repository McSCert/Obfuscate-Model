function removeBlockParams(sys)
% REMOVEBLOCKPARAMS Clear any block parameters that can custom text
% (e.g., 'Tag', 'Description', 'BlockDescription')

    allBlocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    for i = 1:length(allBlocks)
        set_param(allBlocks(i), 'Tag', '');
        set_param(allBlocks(i), 'Description', '');
        try
         set_param(allBlocks(i), 'BlockDescription', '');
        catch
            % For masked blocks this is a read-only parameter
        end
        
        % Subsystem specific
%         if strcmp(get_param(allBlocks(i), 'BlockType'), 'SubSystem')
%             % RTW params
%             set_param(allBlocks(i), 'RTWSystemCode', 'Auto');
%             set_param(allBlocks(i), 'RTWFcnNameOpts', 'Auto');
%             set_param(allBlocks(i), 'RTWFcnName', '');
%             set_param(allBlocks(i), 'RTWFileNameOpts', 'Auto');
%             set_param(allBlocks(i), 'RTWFileName', '');
%         end
    end
end