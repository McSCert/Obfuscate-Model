function updateCallers(simFcn, callers, fcnName, parentSys)
% UPDATECALLERS Update the function prototype of all the callers to a Simulink
% Function
    if ~exist('parentSys', 'var')
        parentSys = [];
    end
    
    try
        parent = get_param(simFcn, 'Parent');
        parent = strsplit(parent, '/');
        prototype = getPrototype(simFcn);
    catch
        return
    end
    for i = 1:length(callers)
        if (length(parent) == 1) && ~isempty(parentSys) && ~strcmp(parent, parentSys)
            split = strsplit(prototype, '= ');
            prototype = strcat(split{1}, {' = '}, parent, '.', split{2});
            prototype = prototype{1};
        end
        set_param(callers{i}, 'FunctionPrototype', prototype);
        if ~isempty(fcnName)
            set_param(callers{i}, 'Name', [fcnName '_caller_' num2str(i)]);
        end
    end
end
