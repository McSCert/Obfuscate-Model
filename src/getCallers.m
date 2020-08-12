function callers = getCallers(argument)
% GETCALLERS Get the function callers for the parent Simulink Function
%            of a trigger port or argument block.
    % Get the Simulink Function for the current argument - should be parent
    simFcn = get_param(argument, 'Parent');
    % Get the callers if that parent is a Simulink Function
    if strcmp(get_param(simFcn, 'IsSimulinkFunction'), 'on') == 1
        callers = findCallers(simFcn);
    else
        callers = [];
    end
end