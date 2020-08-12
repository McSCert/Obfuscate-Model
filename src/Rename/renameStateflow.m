function renameStateflow(sys, varargin)
% RENAMESTATEFLOW Rename chart blocks and their data to generic names.

    % If not args are given, run all checks. 
    % If some args are given, only run those enabled.
    if isempty(varargin)
        default = 1;
    else
        default = 0;
    end

    sfcharts = getInput('sfcharts', varargin, default);
    sfports  = getInput('sfinputs', varargin, default);
    sfevents = getInput('sfevents', varargin, default);
    sfboxes  = getInput('sfboxes',  varargin, default);
    sfstates = getInput('sfstates', varargin, default);

    rt = sfroot;
    model = rt.find('-isa', 'Simulink.BlockDiagram', '-and', 'Name', bdroot(sys));
    charts = model.find('-isa', 'Stateflow.Chart');

    for i = 1:length(charts)
        c = charts(i);

        % Rename charts
        if sfcharts
            c.Name = ['StateflowChart' num2str(i)];
        end
        
        % Rename ports
        if sfports
            input_data = c.find('-isa', 'Stateflow.Data', 'Scope', 'Input');
            for j = 1:length(input_data)
                input_data(j).Name = ['Input' num2str(j)];
            end

            output_data = c.find('-isa', 'Stateflow.Data', 'Scope', 'Output');
            for k = 1:length(output_data)
                output_data(k).Name = ['Output' num2str(k)];
            end
        end

        % Rename events
        if sfevents
            events = c.find('-isa', 'Stateflow.Event');
            for l = 1:length(events)
                events(l).Name = ['Event' num2str(l)];
            end
        end
        
        % Rename boxes
        if sfboxes
            boxes = c.find('-isa', 'Stateflow.Box');
            for n = 1:length(boxes)
                boxes(n).Name = ['Box' num2str(n)];
            end
        end
        
        %% Rename states
        % Save parameter because it needs to be turned off
        if sfstates
            boxes = c.find('-isa', 'Stateflow.Box');
            grp = get(boxes, 'IsGrouped');

            if numel(grp) > 1
                isgrouped = cell2mat(grp);
            else
                isgrouped = grp;
            end
            set(boxes, 'IsGrouped', 0);

            states = c.find('-isa', 'Stateflow.State');
            for m = 1:length(states)
                states(m).Name = ['State' num2str(m)];
            end

            % Turn back on
            for o = 1:length(boxes)
                boxes(o).IsGrouped = isgrouped(o);
            end
        end

        %% Rename functions
        % Functions are used in transitions, etc. so its difficult to change
        %sf_functions = c.find('-isa', 'Stateflow.Function');
        
        %% TODO: Annotations

    end
end