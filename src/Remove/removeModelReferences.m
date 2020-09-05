function removeModelReferences(sys)
% REMOVEMODELREFERENCES Remove references to other models.

    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    for i = 1:length(blocks)
        
        if strcmp(get_param(blocks(i), 'BlockType'), 'ModelReference')
            try
                % Reset parameter values
                set_param(blocks(i), 'ModelNameDialog', '<Enter Model Name>');
                set_param(blocks(i), 'ModelFile', '<Enter Model Name>');
            catch
            end
            try
                set_param(blocks(i), 'ModelName', '<Enter Model Name>');
            catch
            end
        end
    end
end