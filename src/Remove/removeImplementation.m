function removeImplementation(sys)
% REMOVEIMPLEMENTATION Clear system of implementation blocks. Keep interface
% blocks.

    % Remove lines
    allLines = find_system(sys, 'Searchdepth', 1, 'FollowLinks', 'on', 'LookUnderMasks', 'All', 'FindAll', 'on', 'Type', 'line');
    delete_line(allLines);
    
    blocks = find_system(sys, 'SearchDepth', '1', 'FindAll', 'on', 'type', 'block');
    
    % Blocks to keep
    inports = find_system(sys, 'SearchDepth', '1', 'FindAll', 'on', 'type', 'block', 'BlockType', 'Inport');
    outports = find_system(sys, 'SearchDepth', '1', 'FindAll', 'on', 'type', 'block', 'BlockType', 'Outport');
    triggers = find_system(sys, 'SearchDepth', '1', 'FindAll', 'on', 'type', 'block', 'BlockType', 'TriggerPort');
    
    blocks(blocks==get_param(sys,'Handle')) = []; % Remove sys from list
    blocks = setdiff(blocks, inports);
    blocks = setdiff(blocks, outports);
    blocks = setdiff(blocks, triggers);
    delete_block(blocks);
end