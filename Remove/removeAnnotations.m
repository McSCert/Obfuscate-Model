function removeAnnotations(sys)
% REMOVEANNOTATIONS Remove all annotations from the model. 
% Removes any text, area, or image annotations.
    delete(find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'annotation'));
end