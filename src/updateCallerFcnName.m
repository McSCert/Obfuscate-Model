function updateCallerFcnName(callers, oldName, newName)
% UPDATECALLERFCNNAME Updates function name in the prototype for all callers
    % Update the function prototype for each caller
    for i = 1:length(callers)
        oldPrototype = get_param(callers{i}, 'FunctionPrototype');
        newPrototype = strrep(oldPrototype, [' ' oldName '('], ...
                                            [' ' newName '(']);
        set_param(callers{i}, 'FunctionPrototype', newPrototype);
        set_param(callers{i}, 'Name', [newName '_caller']);
    end
end