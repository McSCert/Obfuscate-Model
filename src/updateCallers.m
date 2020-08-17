function updateCallers(simFcn, callers, fcnName)
% UPDATECALLERS Update the function prototype of all the callers to a Simulink
% Function
    try
        prototype = getPrototype(simFcn);
    catch
        return
    end
    for i = 1:length(callers)
        set_param(callers{i}, 'FunctionPrototype', prototype);
        if exist('fcnName', 'var')
            set_param(callers{i}, 'Name', [fcnName '_caller_' num2str(i)]);
        end
    end
end
