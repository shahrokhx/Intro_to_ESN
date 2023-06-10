function timestamp = setup_environment(type)
    % special run-signature
    time_now = datetime;
    timestamp = sprintf('[%4d-%02d-%02d]-[%02d-%02d-%02i]', ...
        time_now.Year, ...
        time_now.Month, ...
        time_now.Day, ...
        time_now.Hour,...
        time_now.Minute, ...
        floor(time_now.Second));
            
    switch type
        case 'type-1'
            format short g

            set(0, 'DefaultLineLineWidth', 2);
            set(0, 'defaultAxesFontName', 'sans serif')
            set(0, 'defaultTextFontName', 'sans serif')

            set(0,'DefaultAxesFontWeight','normal');
            set(0,'DefaultAxesFontSize',22);

            set(0,'DefaultFigureWindowStyle','docked')
            % set(0,'DefaultFigureWindowStyle','normal')
            warning('off','MATLAB:nearlySingularMatrix')
            
            
        case 'type-2'
            format short g

            set(0, 'DefaultLineLineWidth', 2);
            set(0, 'defaultAxesFontName', 'sans serif')
            set(0, 'defaultTextFontName', 'sans serif')

            set(0,'DefaultAxesFontWeight','normal');
            set(0,'DefaultAxesFontSize',22);

            set(0,'DefaultFigureWindowStyle','normal')
            warning('off','MATLAB:nearlySingularMatrix')
            
    end

end