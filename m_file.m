close all
%% Phase portraits with three trajectories - Separate Figures

% Example: 3 trajectories with different initial conditions
% Each trajectory has position (x) and velocity (x_rate)
x1 = OFC.x; x_rate1 = OFC.attitude_rates(:,2);  % Trajectory 1
x2 = OFC.y; x_rate2 = OFC.attitude_rates(:,3);  % Trajectory 2
x3 = OFC.z; x_rate3 = OFC.attitude_rates(:,3);  % Trajectory 3


%% Trajectory 1: Lissajous Curve
% Subsample data for arrows (optional, for clarity)
arrow_step = 500;  % Adjust to control arrow density
arrow_scale = 2;    % Scaling factor for arrows


figure('Name', 'Phase_portrait_Lissajous', 'WindowState', 'maximized');
hold on;
plot(x1, x_rate1, 'color', color_1, 'LineWidth', lw_size);  % Lissajous trajectory
quiver(x1(1:arrow_step:end), x_rate1(1:arrow_step:end), ...
    gradient(x1(1:arrow_step:end)) * arrow_scale, ...
    gradient(x_rate1(1:arrow_step:end)) * arrow_scale, 'r', ...
    'LineWidth', 2, 'MaxHeadSize', 1, 'AutoScale', 'on');
xlabel('Position $z(t)$ - [m]', 'FontSize', x_lab, 'FontWeight', 'normal');
ylabel('Velocity - [m/sec]', 'FontSize', y_lab, 'FontWeight', 'normal');
%title('Trajectory 1: Lissajous Curve', 'FontSize', title_fs, 'Interpreter', 'latex');
box on;
grid off;
set(gca, 'FontSize', gca_fs);
set(0, 'defaultTextInterpreter', 'latex');
hold off;
axis square
saveas(gcf, strcat(figuresdir, 'Phase_portrait_Lissajous_z'), 'fig');
saveas(gcf, strcat(figuresdir, 'Phase_portrait_Lissajous_z'), 'epsc');