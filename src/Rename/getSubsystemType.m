function mask = getSubsystemType(hdls)
% GETSUBSYSTEMTYPE Many blocks in the Simulink language have the BlockType
% parameter set to 'SubSystem'. This function further specifies the type of
% SubSystem.

    if ~iscell(hdls)
        hdls = {hdls};
    end
    mask = cell(size(hdls));
    for idx = 1:length(hdls)
        hdl = hdls{idx};
        if ~strcmpi(get_param(hdl, 'BlockType'), 'SubSystem')
            continue
        end
        isVirtual = strcmp(get_param(hdl, 'IsSubsystemVirtual'), 'on');
        isSubsystemReference = ~isempty(char(get_param(hdl, 'ReferencedSubsystem')));
        
        if isVirtual
            isVariant = strcmp(get_param(hdl, 'Variant'), 'on'); % No way to tell if it's a variant model or a variant subsystem
            if isVariant
                mask{idx} = 'VariantSubsystem';
            elseif isSubsystemReference
                mask{idx} = 'SubsystemReference';
            else
                %mask{idx} = 'VirtualSubsystem';
                mask{idx} = 'Subsystem';
            end
        else

            isEnable = ~isempty(find_system(hdl, 'LookUnderMasks', 'on', 'FollowLinks','on', 'SearchDepth', '1', 'BlockType', 'EnablePort'));
            trigger = find_system(hdl, 'LookUnderMasks', 'on', 'FollowLinks','on', 'SearchDepth', '1', 'BlockType', 'TriggerPort');
            
            if strcmp(get_param(hdl, 'IsSimulinkFunction'), 'on')
                mask{idx} = 'SimulinkFunction';
            elseif isEnable && isempty(trigger)
                mask{idx} = 'EnabledSubsystem';
            elseif ~isempty(trigger)
                
                if isEnable
                    mask{idx} = 'EnabledAndTriggeredSubsystem';
                else
                    t = get_param(trigger, 'TriggerType');
                    if strcmp(t, 'function-call')
                        mask{idx} = 'Function-CallSubsystem';
                    else
                        mask{idx} = 'TriggeredSubsystem';
                    end
                end
            elseif ~isempty(find_system(hdl, 'LookUnderMasks', 'on', 'FollowLinks','on', 'SearchDepth', '1', 'BlockType', 'ActionPort'))
                p = get_param(hdl, 'PortConnectivity');
                src = '';
                for i = 1:length(p)
                    if strcmp(p(i).Type, 'ifaction')
                        src = p(i).SrcBlock;
                        if src > -1
                            src = get_param(src, 'BlockType');
                        end
                    end
                end
                if strcmpi(src, 'SwitchCase')
                    mask{idx} = 'SwitchCaseActionSubsystem';
                else
                    mask{idx} = 'IfActionSubsystem';
                end
            elseif ~isempty(find_system(hdl, 'LookUnderMasks', 'on', 'FollowLinks','on', 'SearchDepth', '1', 'BlockType', 'ForEach'))
                mask{idx} = 'ForEachSubsystem';
            elseif ~isempty(find_system(hdl, 'LookUnderMasks', 'on', 'FollowLinks','on', 'SearchDepth', '1', 'BlockType', 'ForIterator'))
                mask{idx} = 'ForIteratorSubsystem';
            elseif strcmp(get_param(hdl, 'SFBlockType'), 'MATLABFunction')
                mask{idx} = 'MATLABFunction';
            elseif strcmpi(get_param(hdl, 'RTWSystemCode'), 'Reusablefunction')
                mask{idx} = 'CodeReuseSubsystem';
            elseif ~isempty(find_system(hdl, 'LookUnderMasks', 'on', 'FollowLinks','on', 'SearchDepth', '1', 'BlockType', 'ResetPort'))
                mask{idx} = 'ResettableSubsystem';
            elseif ~isempty(find_system(hdl, 'LookUnderMasks', 'on', 'FollowLinks','on', 'SearchDepth', '1', 'BlockType', 'WhileIterator'))
                mask{idx} = 'WhileIteratorSubsystem';
            else
                %mask{idx} = 'AtomicSubsystem';
                mask{idx} = 'AtomicSubsystem';
            end
        end
        
        if size(mask, 1) == 1 && size(mask, 2) == 1
            mask = char(mask);
        end
    end
end