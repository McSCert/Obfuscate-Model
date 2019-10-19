function renamePorts(sys)
% RENAMEPORTS Give all ports generic names. Show names for inspection purposes.

    % Inports
    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block', 'BlockType', 'Inport');
    for i = 1:length(blocks)
        num = get_param(blocks(i), 'Port');
        set_param(blocks(i), 'Name', ['Inport' num2str(num)]);
        set_param(blocks(i), 'ShowName', 'on');
        try
            set_param(blocks(i), 'HideAutomaticName', 'off');
        catch ME
            if ~strcmp(ME.identifier, 'Simulink:Commands:ParamUnknown')
                rethrow(ME)
            end
        end
    end
    
    % Outports
    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block', 'BlockType', 'Outport');
    for j = 1:length(blocks)
        num = get_param(blocks(j), 'Port');
        set_param(blocks(j), 'Name', ['Outport' num2str(num)]);
        set_param(blocks(j), 'ShowName', 'on');
        try
            set_param(blocks(j), 'HideAutomaticName', 'off');
        catch ME
            if ~strcmp(ME.identifier, 'Simulink:Commands:ParamUnknown')
                rethrow(ME)
            end
        end
    end
end