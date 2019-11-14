function removeDescriptions(sys)
% REMOVEDESCRIPTIONS Remove all Description parameters in lines, blocks and
% annotations.

    all = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    all = [all; find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'annotation')];
    all = [all; find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'line')];
    for i = 1:length(all)
        set_param(all(i), 'Description', '');
        try
            set_param(all(i), 'BlockDescription', '');
            set_param(all(i), 'Tag', '');
        catch
        end
    end
            
%         % Subsystem specific
%         if strcmp(get_param(all(i), 'BlockType'), 'SubSystem')
%             % RTW params
%             set_param(all(i), 'RTWSystemCode', 'Auto');
%             set_param(all(i), 'RTWFcnNameOpts', 'Auto');
%             set_param(all(i), 'RTWFcnName', '');
%             set_param(all(i), 'RTWFileNameOpts', 'Auto');
%             set_param(all(i), 'RTWFileName', '');
%         end
end