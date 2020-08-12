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
        updateCallers(callers, oldName, newName);
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
        updateCallers(callers, oldName, newName);
    end
end

function callers = getCallers(argument)
    % Get the Simulink Function for the current argumet - should be parent
    simFcn = get_param(argument, 'Parent');
    % Get the callers if that parent is a Simulink Function
    if strcmp(get_param(simFcn, 'IsSimulinkFunction'), 'on') == 1
        callers = findCallers(simFcn);
    end
end

function updateCallers(callers, oldName, newName)
    % Update the function prototype for each caller
    for i = 1:length(callers)
        oldPrototype = get_param(callers{i}, 'FunctionPrototype');
        newPrototype = oldPrototype;
        argumentScenario = 1;
        while strcmp(oldPrototype, newPrototype) == 1
            switch argumentScenario
                case 1
                    newPrototype = strrep(oldPrototype, ['[' oldName ','], ['[' newName ',']);
                case 2
                    newPrototype = strrep(oldPrototype, [',' oldName ','], [',' newName ',']);
                case 3
                    newPrototype = strrep(oldPrototype, [',' oldName ']'], [',' newName ']']);
                case 4
                    newPrototype = strrep(oldPrototype, ['(' oldName ','], ['(' newName ',']);
                case 5
                    newPrototype = strrep(oldPrototype, [',' oldName ')'], [',' newName ')']);
                case 6
                    newPrototype = strrep(oldPrototype, ['(' oldName ')'], ['(' newName ')']);
                case 7
                    newPrototype = strrep(oldPrototype, [oldName ' '], [newName '']);
                otherwise
                    disp('Argument not found in prototype.')
                    return;
            end
            argumentScenario = argumentScenario + 1;
        end
        set_param(callers{i}, 'FunctionPrototype', newPrototype);
    end
end