function hideSignalPropagation(sys, varargin)
% HIDECONTENTPREVIEW Enable/disable signal propagation.
%
%   Inputs:
%       sys     Name of Simulink model or subsystem.
%       show    Whether to disable signal propagation (1), or not (0). [Default is 1]
%
%   Outputs:
%       N/A
%
%   Side Effects:
%       Enables or disables the signal propagation

    if nargin > 1
        hide = varargin{1};
    else
        hide = true;
    end
    
    lines = find_system(sys, 'FindAll', 'on', 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'type', 'line');
    
    if hide
        for i = 1:length(lines)
            set(lines(i), 'signalPropagation', 'off');
        end
    else
        for i = 1:length(lines)
            try
                set(lines(i), 'signalPropagation', 'on');
            catch ME
                if ~strcmp(ME.identifier, 'Simulink:Signals:NoPropSigLabThroughBlock')
                    rethrown(ME)
                end
            end
        end
    end
end