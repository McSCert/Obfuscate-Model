function removeAnnotations(sys)
% REMOVETEXT Remove all annotations from the model. 
% Removes any text, area, or image.
    delete(find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'annotation'));
end