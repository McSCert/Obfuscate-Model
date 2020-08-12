function updateCallerArgs(callers, oldName, newName)
% UPDATECALLERARGS Updates the arguments in the prototype for all callers    
    % Update the function prototype for each caller
    for i = 1:length(callers)
        oldPrototype = get_param(callers{i}, 'FunctionPrototype');
        newPrototype = oldPrototype;
        argumentScenario = 1;
        while strcmp(oldPrototype, newPrototype) == 1
            switch argumentScenario
                case 1
                    newPrototype = strrep(oldPrototype, ['[' oldName ','], ...
                                                        ['[' newName ',']);
                case 2
                    newPrototype = strrep(oldPrototype, [',' oldName ','], ...
                                                        [',' newName ',']);
                case 3
                    newPrototype = strrep(oldPrototype, [',' oldName ']'], ...
                                                        [',' newName ']']);
                case 4
                    newPrototype = strrep(oldPrototype, ['(' oldName ','], ...
                                                        ['(' newName ',']);
                case 5
                    newPrototype = strrep(oldPrototype, [',' oldName ')'], ...
                                                        [',' newName ')']);
                case 6
                    newPrototype = strrep(oldPrototype, ['(' oldName ')'], ...
                                                        ['(' newName ')']);
                case 7
                    newPrototype = strrep(oldPrototype, [oldName ' '], ...
                                                        [newName '']);
                otherwise
                    disp('Argument not found in prototype.')
                    return;
            end
            argumentScenario = argumentScenario + 1;
        end
        set_param(callers{i}, 'FunctionPrototype', newPrototype);
    end
end