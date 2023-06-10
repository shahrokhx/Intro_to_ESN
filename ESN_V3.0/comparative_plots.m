function comparative_plots(outputs, params, f)
    figure(f);clf;
    pallete1 = ["#50514f","#f25f5c","#247ba0","#70c1b3","#da627d"];
    pallete2 = ["#f75c03","#d90368","#820263","#291720","#04a777"];
    % ------------------------------------------------------------------- %
    % time = params.time(outputs.resampling_index);
    time = params.time;
    data = outputs.inputs(params.target_index,:);
    input_size = size(data, 1);
    
    pretrain_index = outputs.pretrain_index;
    train_index = outputs.train_index;
    test_index = outputs.test_index;
    
    train_length = length(pretrain_index) + length(train_index);
    pred = outputs.pred;
    % ------------------------------------------------------------------- %
    ax1 = subplot(2,1,1);
    hold(ax1, 'on')
    for inp = 1 : input_size 
        plot(ax1, time(pretrain_index), data(inp, pretrain_index), ...
            'Color','k', ...
            'DisplayName',['X_{ptr}^',num2str(inp)]);
        
        plot(ax1, time(train_index), data(inp,train_index), ...
            'Color', pallete1(inp), ...
            'DisplayName',['X_{tr}^',num2str(inp)]);
        plot(ax1, time(test_index), data(inp,test_index), ...
            'Color', pallete1(inp), ...
            'DisplayName',['X_{t}^',num2str(inp)]);
    end
    for out = 1 : size(pred,1)
        line_pred_ax1 = plot(ax1, time(test_index),  pred(out,:), ...
        'Color', pallete2(out), ...
        'DisplayName',['Y_{t}^',num2str(out)]);
    end
    line(ax1,[time(train_length), time(train_length)],...
            [ax1.YLim(1), ax1.YLim(2)], ...
            'LineWidth', 2, 'color', 'k', 'DisplayName', 'train|test');
    legend(ax1,'location','northoutside','Orientation','horizontal')
    
    if isfield(outputs, 'pred_on_train')
        pred_on_train = outputs.pred_on_train;
        for out = 1 : size(pred_on_train, 1)
            lpred_train = plot(...
                ax1, ...
                time(train_index), ...
                pred_on_train(out, :), ...
                'Color', 'g', ...
                'DisplayName',['Y_{tr}^',num2str(out)] ...
            );
            
        end
    end
    % ------------------------------------------------------------------- %
    ax2 = subplot(2,1,2);
    hold(ax2, 'on')
    % {
    for inp = 1 : input_size
        plot(ax2, time(test_index), data(inp,test_index), ...
            'Color', pallete1(inp));
    end
    for out = 1 : size(pred,1)
        line_pred_ax2 = plot(ax2, time(test_index), pred(out,:), ...
            'Color', pallete2(out));
        line_pred_ax2.LineWidth=3;
        line_pred_ax2.Color(4)=0.7;
    end
    %}
    %{
    for inp = 1 : input_size
        plot(ax2, time(test_index), data(inp,test_index), ...
            'Color', '#00afb9');
    end
    for out = 1 : size(pred,1)
        line_pred_ax2 = plot(ax2, time(test_index), pred(out,:), ...
            'Color', '#f07167');
        line_pred_ax2.LineWidth=3;
        line_pred_ax2.Color(4)=0.7;
    end
    %}
    % legend(ax2,'test data','prediction results')
    title(ax2, sprintf('Prediction'))
end