function renameStateflow(sys)
% RENAMESTATEFLOW Rename chart blocks and their data to generic names.

    rt = sfroot;
    model = rt.find('-isa', 'Simulink.BlockDiagram', '-and', 'Name', bdroot(sys));
    charts = model.find('-isa', 'Stateflow.Chart');

    for i = 1:length(charts)
        c = charts(i);

        % Rename chart
        c.Name = ['StateflowChart' num2str(i)];

        % Rename inputs
        input_data = c.find('-isa', 'Stateflow.Data', 'Scope', 'Input');
        for j = 1:length(input_data)
            input_data(j).Name = ['Input' num2str(j)];
        end

        % Rename outputs
        output_data = c.find('-isa', 'Stateflow.Data', 'Scope', 'Output');
        for k = 1:length(output_data)
            output_data(k).Name = ['Output' num2str(k)];
        end

        % Rename events
        output_data = c.find('-isa', 'Stateflow.Event');
        for l = 1:length(events)
            events(l).Name = ['Event' num2str(l)];
        end

        % Boxes
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

        %% Rename functions
        % Functions are used in transitions, etc. so its difficult to change
        %sf_functions = c.find('-isa', 'Stateflow.Function');

        %% TODO: Annotations

    end
end