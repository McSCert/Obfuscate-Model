function renameStateflow(sys)
% RENAMESTATEFLOW Rename chart blocks to generic names.

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
    end
end