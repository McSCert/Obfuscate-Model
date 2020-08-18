function renameSimFcns(sys)
% RENAMESIMFCNS Rename Simulink Functions to generic names, and update callers.
    % Triggers
    triggers = find_system(sys, 'BlockType', 'TriggerPort');
    num = 1;
    for i = 1:length(triggers)
        if strcmp(get_param(triggers{i}, 'IsSimulinkFunction'), 'on')
            simFcn = get_param(triggers{i}, 'Parent');
            callers = findCallers(simFcn);
            
            newName = ['f' num2str(num)];
            set_param(triggers{i}, 'FunctionName', newName);
            
            num = num + 1;
            
            % Update the Simulink Function callers
            if ~isempty(callers)
                updateCallers(simFcn, callers, newName)
            end
        end
    end  
end