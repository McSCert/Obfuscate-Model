function removeAnnotations(sys)
% REMOVEANNOTATIONS Remove all annotations from the model. 
% Removes any text, area, or image annotations.
    delete(find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'annotation'));
    % Remove block annotations
    blocks = Simulink.findBlocks(sys);
    for i = 1:length(blocks)
       set_param(blocks(i), 'AttributesFormatString', ''); 
    end
end