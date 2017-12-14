function renamePorts(sys)
% RENAMEPORTS Give all ports generic names. Show names for inspection purposes.

    % Inports
    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block', 'BlockType', 'Inport');
    for i = 1:length(blocks)
        set_param(blocks(i), 'Name', ['Inport' num2str(i)]);
        set_param(blocks(i), 'ShowName', 'on');
        set_param(blocks(i), 'HideAutomaticName', 'off');
    end
    
    % Outports
    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block', 'BlockType', 'Outport');
    for j = 1:length(blocks)
        set_param(blocks(j), 'Name', ['Outport' num2str(j)]);
        set_param(blocks(j), 'ShowName', 'on');
        set_param(blocks(j), 'HideAutomaticName', 'off');
    end
end