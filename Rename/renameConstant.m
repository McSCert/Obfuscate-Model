function renameConstant(sys, name, newname)
% RENAMECONSTANT Changes the value of all constant blocks that share the same 
%   value with a new value. This is the "Value" parameter, not the name parameter. 
%   Be careful, as this function does not just work on constants, it works on 
%   any block with a "Value" parameter, so be wary. Typically used when the 
%   constant block has a calibration as its value.

    blocks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Constant',  'Value', name);
    for i = 1:length(blocks)
        set_param(blocks{i}, 'Value', newname);
    end
end