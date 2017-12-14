function removeModelInformation(sys)
% REMOVEMODELINFORMATION Reset the model information.

    set_param(sys, 'Creator', 'user');
    set_param(sys, 'LastModifiedBy', 'user');
    
    date = datestr(now,'ddd mmm dd HH:MM:SS yyyy')';
    set_param(sys, 'Created', date);
    set_param(sys, 'LastModifiedDate', date);
    
    set_param(sys, 'ModifiedComment', '');
    set_param(sys, 'ModifiedHistory', '');
    set_param(sys, 'ModelVersion', '1.0');       
end