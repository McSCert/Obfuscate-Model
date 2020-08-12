function removeLinks(sys)
% REMOVELINKS Break block and library links. Links can be used to reference custom
% blocks or other models/libraries that should not be provided.

    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    for i = 1:length(blocks)
        set_param(blocks(i), 'ReferenceBlock', '');

        if strcmp(get_param(blocks(i), 'BlockType'), 'Reference')
            try
                set_param(blocks(i), 'SourceBlock', '');
                set_param(blocks(i), 'LinkStatus', 'none');
            catch
            end
        elseif strcmp(get_param(blocks(i), 'BlockType'), 'ModelReference')
            try
                set_param(blocks(i), 'LinkStatus', 'none');
                set_param(blocks(i), 'ModelNameDialog', '<Enter Model Name>');
                set_param(blocks(i), 'ModelFile', '<Enter Model Name>');
                set_param(blocks(i), 'ModelName', '<Enter Model Name>');
            catch
            end
        end
    end
end