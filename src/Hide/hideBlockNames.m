function hideBlocksNames(sys, varargin)
% HIDEBLOCKNAMES Make block names visible or hidden.
%
%   Inputs:
%       sys     Name of Simulink model or subsystem.
%       show    Whether to hide the name (1), or not (0). [Default is 1]
%
%   Outputs:
%       N/A
%
%   Side Effects:
%       Shows or hides the block name.

    if nargin > 1
        hide = varargin{1};
    else
        hide = true;
    end
    
    blocks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'block');
    
    if hide
        for i = 1:length(blocks)
            set_param(blocks{i}, 'ShowName', 'off');
            set_param(blocks{i}, 'HideAutomaticName', 'on');
        end
    else
        for i = 1:length(blocks)
            set_param(blocks{i}, 'ShowName', 'on');
            set_param(blocks{i}, 'HideAutomaticName', 'off');
        end
    end
end