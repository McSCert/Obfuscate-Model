function hideContentPreview(sys, varargin)
% HIDECONTENTPREVIEW Make the content preview of Subsystems visible or hidden.
%
%   Inputs:
%       sys     Name of Simulink model or subsystem.
%       show    Whether to hide the preview (1), or not (0). [Default is 1]
%
%   Outputs:
%       N/A
%
%   Side Effects:
%       Shows or hides the content preview.

    if nargin > 1
        hide = varargin{1};
    else
        hide = true;
    end
    
    blocks = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'SubSystem');
    blocks = get_param(blocks, 'Handle');
    
    if hide
        for i = 1:length(blocks)
            set(blocks{i}, 'ContentPreviewEnabled', 'Off'); 
        end
    else
        for i = 1:length(blocks)
            set(blocks{i}, 'ContentPreviewEnabled', 'On');
        end
    end
end