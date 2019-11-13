function removeBlockCallbacks(sys)
% REMOVEBLOCKCALLBACKS Clear the various callback parameters on blocks. 
% These parameters may include custom scripts.
%
% See: https://www.mathworks.com/help/simulink/ug/block-callbacks.html

    blocks = find_system(sys, 'FindAll', 'on', 'FollowLinks', 'on', 'type', 'block');
    for i = 1:length(blocks)
        try
            set_param(blocks(i), 'CopyFcn', '');
            set_param(blocks(i), 'DeleteFcn', '');
            set_param(blocks(i), 'LoadFcn', '');
            set_param(blocks(i), 'ModelCloseFcn', '');
            set_param(blocks(i), 'PreSaveFcn', '');
            set_param(blocks(i), 'PostSaveFcn', '');
            set_param(blocks(i), 'InitFcn', '');
            set_param(blocks(i), 'StartFcn', '');
            set_param(blocks(i), 'PauseFcn', '');
            set_param(blocks(i), 'ContinueFcn', '');
            set_param(blocks(i), 'StopFcn', '');
            set_param(blocks(i), 'NameChangeFcn', '');
            set_param(blocks(i), 'ClipboardFcn', '');
            set_param(blocks(i), 'DestroyFcn', '');
            set_param(blocks(i), 'PreCopyFcn', '');
            set_param(blocks(i), 'OpenFcn', '');
            set_param(blocks(i), 'CloseFcn', '');
            set_param(blocks(i), 'PreDeleteFcn', '');
            set_param(blocks(i), 'ParentCloseFcn', '');
            set_param(blocks(i), 'MoveFcn', '');
        catch
            % Skip. Reference blocks won't allow it.
        end
    end
end