function fancy_plot(x, y, plot_type, custom_settings)
    % Handle optional input
    if nargin < 4
        custom_settings = struct();
    end

    % Default settings
    default_settings.font_size = 60;
    default_settings.font_size_legend = 40;
    default_settings.line_width = 4;
    default_settings.marker_size = 24;
    default_settings.marker_type = '-o';
    default_settings.font_name = 'Serif';
    default_settings.legend_box = 'on';
    default_settings.legend_location = 'best';   % <-- new default
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

    % Override defaults with user settings
    fields = fieldnames(custom_settings);
    for i = 1:numel(fields)
        default_settings.(fields{i}) = custom_settings.(fields{i});
    end
    s = default_settings;

    % If user gave y_label but not legend_label, use y_label for both
    if isfield(custom_settings, 'y_label') && ~isfield(custom_settings, 'legend_label')
        s.legend_label = s.y_label;
    end

    % Compute marker indices
    marker_step = max(1, round(length(x) / s.marker_div));
    marker_indices = 1:marker_step:length(x);

    % Create figure
    figure('Position', [400, 400, 800, 800]);

    % Plot based on type
    switch lower(plot_type)
        case 'linear'
            plot(x, y, s.marker_type, 'LineWidth', s.line_width, ...
                'MarkerSize', s.marker_size, 'MarkerIndices', marker_indices);
        case 'loglog'
            loglog(x, y, s.marker_type, 'LineWidth', s.line_width, ...
                'MarkerSize', s.marker_size, 'MarkerIndices', marker_indices);
        case 'semilogy'
            semilogy(x, y, s.marker_type, 'LineWidth', s.line_width, ...
                'MarkerSize', s.marker_size, 'MarkerIndices', marker_indices);
        case 'semilogx'
            semilogx(x, y, s.marker_type, 'LineWidth', s.line_width, ...
                'MarkerSize', s.marker_size, 'MarkerIndices', marker_indices);
        otherwise
            error('Unknown plot type: %s', plot_type);
    end

    % Labels and legend
    xlabel(s.x_label, 'Interpreter', 'latex', 'FontSize', s.font_size);
    ylabel(s.y_label, 'Interpreter', 'latex', 'FontSize', s.font_size);
    legend({s.legend_label}, 'Interpreter', 'latex', ...
        'FontSize', s.font_size_legend, 'Location', s.legend_location, 'Box', s.legend_box);

    axis square

    % Optional: set limits and ticks
    if ~isempty(s.x_lim), xlim(s.x_lim); end
    if ~isempty(s.y_lim), ylim(s.y_lim); end

    if ~isempty(s.x_ticks), xticks(s.x_ticks); end
    if ~isempty(s.x_ticklabels)
        if iscell(s.x_ticklabels)
            xticklabels(string(s.x_ticklabels));
        else
            xticklabels(s.x_ticklabels);
        end
    end

    if ~isempty(s.y_ticks), yticks(s.y_ticks); end
    if ~isempty(s.y_ticklabels)
        if iscell(s.y_ticklabels)
            yticklabels(string(s.y_ticklabels));
        else
            yticklabels(s.y_ticklabels);
        end
    end

    disp(s.x_ticklabels)

    % Axes styling
    set(gca, 'FontSize', s.font_size, 'FontName', s.font_name, ...
        'LineWidth', s.line_width, 'Box', 'on', 'TickLabelInterpreter', 'latex');
end
