clear; clc; close all;

% Define data
x = -pi : 0.01 : pi;
y = sin(x);
y_abs = abs(y) + 1e-2; % avoid log(0)



%% 1. Linear plot
figure('Position',[100,100,800,800]);

font_size = 60;
font_size_legend = 40;
line_width = 4;
marker_size = 24;
marker_type = '-o';
font_name = 'Serif';

plot(x, y, marker_type, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', 1:round(length(x)/20):length(x));
legend({'$\sin(x)$'}, 'Interpreter', 'latex', ...
    'FontSize', font_size_legend, 'Location', 'best', "Box","on");
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel('$\sin(x)$', 'Interpreter', 'latex', 'FontSize', font_size);
xlim([-pi-0.2  pi+0.2]);
ylim([-1.2 1.2]);
xticks([-pi -pi/2 0 pi/2 pi]);
xticklabels({'$-\pi$', '$-\frac{\pi}{2}$', '$0$', '$\frac{\pi}{2}$', '$\pi$'});
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'FontSize', font_size, 'FontName', font_name, ...
    'LineWidth', line_width, 'Box', 'on');
axis square

%% 2. Log-log plot
x_pos = linspace(0.01, pi, 500); % positive x only
y_log = abs(sin(x_pos)) + 1e-2;
figure('Position',[950,100,800,800]);
font_size = 60;
font_size_legend = 40;
line_width = 4;
marker_size = 24;
marker_type = '-*';
font_name = 'Serif';
loglog(x_pos, y_log, marker_type, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', 1:round(length(x_pos)/20):length(x_pos));
legend({'$|\sin(x)| + 10^{-2}$'}, 'Interpreter', 'latex', ...
    'FontSize', font_size_legend, 'Location', 'best', "Box","on");
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel('$\sin(x)$ (log-log scale)', 'Interpreter', 'latex', 'FontSize', font_size);
set(gca, 'FontSize', font_size, 'FontName', font_name, ...
    'LineWidth', line_width, 'Box', 'on');
axis square

%% 3. Semilogy plot
figure('Position',[500,950,800,800]);
font_size = 60;
font_size_legend = 40;
line_width = 4;
marker_size = 24;
marker_type = '-s';
font_name = 'Serif';
semilogy(x, y_abs, marker_type, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', 1:round(length(x)/20):length(x));
legend({'$|\sin(x)| + 10^{-2}$'}, 'Interpreter', 'latex', ...
    'FontSize', font_size_legend, 'Location', 'best', "Box","on");
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel('$\sin(x)$ (semilogy scale)', 'Interpreter', 'latex', 'FontSize', font_size);
xlim([-pi-0.2 pi+0.2]);
xticks([-pi -pi/2 0 pi/2 pi]);
xticklabels({'$-\pi$', '$-\frac{\pi}{2}$', '$0$', '$\frac{\pi}{2}$', '$\pi$'});
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'FontSize', font_size, 'FontName', font_name, ...
    'LineWidth', line_width, 'Box', 'on');
axis square

%% 4. Semilogx plot

figure('Position',[950,950,800,800]);
font_size = 60;
font_size_legend = 40;
line_width = 4;
marker_size = 24;
marker_type = '-^';
font_name = 'Serif';
semilogx(x_pos, y_log, marker_type, 'LineWidth', line_width, ...
    'MarkerSize', marker_size, 'MarkerIndices', 1:round(length(x_pos)/20):length(x_pos));
legend({'$|\sin(x)| + 10^{-2}$'}, 'Interpreter', 'latex', ...
    'FontSize', font_size_legend, 'Location', 'best', "Box","on");
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel('$\sin(x)$ (semilogx scale)', 'Interpreter', 'latex', 'FontSize', font_size);
set(gca, 'FontSize', font_size, 'FontName', font_name, ...
    'LineWidth', line_width, 'Box', 'on');
axis square
