function renameGotos(sys)
% RENAMEGOTOS Give all goto/froms generic names. 
% Should be run from the root to avoid overlapping names.

    % Gotos
    gotos = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Goto');
    n = 1;
    for i = 1:length(gotos)
        set_param(gotos{i}, 'ShowName', 'on');
        set_param(gotos{i}, 'HideAutomaticName', 'off');
        
        changed = false;
        while(~changed)
            try
                set_param(gotos{i}, 'Name', ['Goto' num2str(n)]);
            catch
                n = n+1;
            end
            changed = true;
        end
    end
    
    % Froms
    froms = find_system(sys, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'From');   
    n = 1;
    for i = 1:length(froms)
        set_param(froms{i}, 'ShowName', 'on');
        set_param(froms{i}, 'HideAutomaticName', 'off');
        
        changed = false;
        while(~changed)
            try
                set_param(froms{i}, 'Name', ['From' num2str(n)]);
            catch
                n = n+1;
            end
            changed = true;
        end
    end
end