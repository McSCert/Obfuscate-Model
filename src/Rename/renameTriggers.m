function renameTriggers(sys)
% RENAMETRIGGERS Rename trigger and enable blocks to generic names.

    % Trigger
    trig = find_system(sys, 'BlockType', 'TriggerPort');
    for i = 1:length(trig)
       set_param(trig{i}, 'Name', 'Trigger');
    end
    
    % Enable
    enable = find_system(sys, 'BlockType', 'EnablePort');
    for j = 1:length(enable)
       set_param(enable{j}, 'Name', 'Enable');
    end
end