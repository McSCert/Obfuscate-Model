function renameSimFcns(sys)
% RENAMESIMFCNS Rename Simulink Functions to generic names, and update callers.
    % Triggers
    triggers = find_system(sys, 'BlockType', 'TriggerPort');
    num = 1;
    for i = 1:length(triggers)
      	oldName = get_param(triggers{i}, 'FunctionName');
        callers = getCallers(triggers{i});
        if strcmp(get_param(triggers{i}, 'IsSimulinkFunction'), 'on') == 1
            newName = ['f' num2str(num)];
            set_param(triggers{i}, 'FunctionName', newName);
            if ~isempty(callers)
                updateCallerFcnName(callers, oldName, newName);
            end
            num = num + 1;
        end
    end  
end