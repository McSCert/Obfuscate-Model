function removeLinks(sys)
% REMOVELINKS Reset block links. Links can be used to reference custom
% blocks that should not be exposed.

    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    for i = 1:length(blocks)
        set_param(blocks(i), 'ReferenceBlock', '');
%         if strcmp(get_param(blocks(i), 'BlockType'), 'Reference')
%             try
%                 set_param(blocks(i), 'SourceBlock', '');
%                 set_param(blocks(i), 'LinkStatus', 'none');
%             catch
%             end
%         end
    end
end 