function renameSubsystems(sys)
% RENAMESUBSYSTEMS Give all subsystems generic names. Should be run from the
% root.
    allSubsystems = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'BlockType', 'SubSystem', 'IsSimulinkFunction', 'off');
    allSimFuncs  = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'BlockType', 'SubSystem', 'IsSimulinkFunction', 'on');

    % Subsystems
    for i = length(allSubsystems):-1:1 % Need to go backwards, otherwise paths will be out of date
        changed = false;
        num = 1;
        while ~changed
            try
                set_param(allSubsystems(i), 'Name', ['Subsystem' num2str(num)]);
                changed = true;
            catch
                num = num + 1;
            end
        end
    end

    % Simulink Functions
    for j = length(allSimFuncs):-1:1
        changed = false;
        num = 1;
        while ~changed
            try
                set_param(allSimFuncs(j), 'Name', ['Simulink Function' num2str(num)]);
                changed = true;
            catch
                num = num + 1;
            end
        end
    end
end