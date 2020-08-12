function renameArgs(sys)
% RENAMEARGS Give all Simulink Function arguments generic names
    allArgIns   = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', ...
                             'BlockType', 'ArgIn');
    allArgOuts  = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', ...
                             'BlockType', 'ArgOut');           

    % Argument Inputs
    for i = 1:length(allArgIns)
        changed = false;
        num = 1;
        callers = getCallers(allArgIns(i));
        oldName = get_param(allArgIns(i), 'ArgumentName');
        while ~changed
            try
                newName = ['u' num2str(num)];
                set_param(allArgIns(i), 'Name', newName);
                set_param(allArgIns(i), 'ArgumentName', newName);
                changed = true;
            catch
                num = num + 1;
            end
        end
        % Update the function callers that use the argument
        updateCallerArgs(callers, oldName, newName);
    end

    % Argument Outputs
    for j = 1:length(allArgOuts)
        changed = false;
        num = 1;
        callers = getCallers(allArgOuts(j));
        oldName = get_param(allArgOuts(j), 'ArgumentName');
        while ~changed
            try
                newName = ['y' num2str(num)];
                set_param(allArgOuts(j), 'Name', newName);
                set_param(allArgOuts(j), 'ArgumentName', newName);
                changed = true;
            catch
                num = num + 1;
            end
        end
        updateCallerArgs(callers, oldName, newName);
    end
end