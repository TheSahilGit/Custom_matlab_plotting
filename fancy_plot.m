function fancy_plot(x, y, plot_type, new_figure, finalize_legend, custom_settings)
    if nargin < 6
        custom_settings = struct();
    end
    if nargin < 5
        finalize_legend = false;
    end
    if nargin < 4
        new_figure = true;
    end

    % Default settings
    default_settings.font_size = 60;
    default_settings.font_size_legend = 40;
    default_settings.line_width = 4;
    default_settings.marker_size = 24;
    default_settings.marker_type = '-o';
    default_settings.font_name = 'Serif';
    default_settings.legend_box = 'on';
    default_settings.legend_location = 'best';
    default_settings.x_label = '$x$';
    default_settings.y_label = '$y$';
    default_settings.legend_label = '$y$';
    default_settings.x_lim = [];
    default_settings.y_lim = [];
    default_settings.x_ticks = [];
    default_settings.y_ticks = [];
    default_settings.x_ticklabels = [];
    default_settings.y_ticklabels = [];
    default_settings.marker_div = length(x);
    default_settings.color = [];

    % Override defaults
    s = default_settings;
    f = fieldnames(custom_settings);
    for i = 1:numel(f)
        s.(f{i}) = custom_settings.(f{i});
    end

    if isfield(custom_settings, 'y_label') && ~isfield(custom_settings, 'legend_label')
        s.legend_label = s.y_label;
    end

    % Create new figure
    if new_figure
        figure('Position', [400, 400, 800, 800]);
        %hold on;
        setappdata(gcf, 'plot_handles', []);
        setappdata(gcf, 'plot_labels', {});
    end

    % Marker indices
    marker_step = max(1, round(length(x) / s.marker_div));
    marker_indices = 1:marker_step:length(x);

    % Build args
    plot_args = {x, y, s.marker_type, ...
        'LineWidth', s.line_width, ...
        'MarkerSize', s.marker_size, ...
        'MarkerIndices', marker_indices};
    if ~isempty(s.color)
        plot_args = [plot_args, {'Color', s.color}];
    end

    % Actual plot
    switch lower(plot_type)
        case 'linear',   h = plot(plot_args{:});
        case 'loglog',   h = loglog(plot_args{:});
        case 'semilogy', h = semilogy(plot_args{:});
        case 'semilogx', h = semilogx(plot_args{:});
        otherwise,       error('Unknown plot type: %s', plot_type);
    end

    hold on;  % <-- move here


    % Collect handles & labels
    fig = gcf;
    handles = getappdata(fig, 'plot_handles');
    labels = getappdata(fig, 'plot_labels');
    handles = [handles, h];
    labels = [labels, s.legend_label];
    setappdata(fig, 'plot_handles', handles);
    setappdata(fig, 'plot_labels', labels);

    % Labels
    xlabel(s.x_label, 'Interpreter', 'latex', 'FontSize', s.font_size);
    ylabel(s.y_label, 'Interpreter', 'latex', 'FontSize', s.font_size);

    % Ticks
    if ~isempty(s.x_lim), xlim(s.x_lim); end
    if ~isempty(s.y_lim), ylim(s.y_lim); end
    if ~isempty(s.x_ticks), xticks(s.x_ticks); end
    if ~isempty(s.x_ticklabels), xticklabels(string(s.x_ticklabels)); end
    if ~isempty(s.y_ticks), yticks(s.y_ticks); end
    if ~isempty(s.y_ticklabels), yticklabels(string(s.y_ticklabels)); end

    set(gca, 'FontSize', s.font_size, 'FontName', s.font_name, ...
        'LineWidth', s.line_width, 'Box', 'on', 'TickLabelInterpreter', 'latex');
    axis square;

    % Finalize legend if needed
    if finalize_legend
        legend(handles, labels, 'Interpreter', 'latex', ...
            'FontSize', s.font_size_legend, ...
            'Location', s.legend_location, ...
            'Box', s.legend_box);
    end
end
