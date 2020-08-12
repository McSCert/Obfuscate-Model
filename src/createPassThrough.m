function createPassThrough(sys)
% CREATEPASSTHROUGH Connect inports to outports where possible. Add terminators 
% otherwise.    

    removeImplementation(sys)
    
    inports = find_system(sys, 'SearchDepth', '1', 'FindAll', 'on', 'type', 'block', 'BlockType', 'Inport');
    outports = find_system(sys, 'SearchDepth', '1', 'FindAll', 'on', 'type', 'block', 'BlockType', 'Outport');
    
    for i = 1:min(length(inports),length(outports))
        connectBlocks(sys, inports(i), outports(i));
    end
    
    % Terminate extra inports
    % TODO

    % Branch to extra outports
    % TODO
end