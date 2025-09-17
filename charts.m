close all

%%                      COLOR CODES FOR PLOTTING
figuresdir = 'C:\Users\Nigar\Desktop\MUSTAFA_paper\';
color_1 = [0 0.4470 0.7410];            % Metalic blue
color_2 = [0.8500 0.3250 0.0980];       % metalic brown
color_3 = [0.9290 0.6940 0.1250];       % metalic yellow
color_4 = [0.4940 0.1840 0.5560];       % metalic purple
color_5 = [0.4660 0.6740 0.1880];       % metalic green
color_6 = [0.6350 0.0780 0.1840];       % maroon
color_7 = [1 0 0];                      % Red
color_8 = [0 1 0];                      % Green
color_9 = [0 0 1];                      % Blue
color_10 = [1 1 0];                     % Yellow
color_11 = [0.3010 0.7450 0.9330];      % sky blue

% Font and figure settings
legend_fs = 40;             
a_len = 115;                
b_len = 60;                 
gca_fs = 44;                
x_lab = 48;                 
y_lab = 48;                 
lw_size = 8;                

% === Load Workspace Data ===
x_sim1_data = OFC.pos_x_error; 
x_sim2_data = OFC.x_estimated - OFC.x_des;
x_sim3_data = SFC.pos_x_error;

y_sim1_data = OFC.pos_y_error; 
y_sim2_data = OFC.y_estimated - OFC.y_des;
y_sim3_data = SFC.pos_y_error;

z_sim1_data = OFC.pos_z_error; 
z_sim2_data = OFC.z_estimated - OFC.z_des;
z_sim3_data = SFC.pos_z_error;

% === Process the Data ===
x_sim1 = sqrt(mean(x_sim1_data.^2)); 
x_sim2 = sqrt(mean(x_sim2_data.^2)); 
x_sim3 = sqrt(mean(x_sim3_data.^2)); 

y_sim1 = sqrt(mean(y_sim1_data.^2)); 
y_sim2 = sqrt(mean(y_sim2_data.^2)); 
y_sim3 = sqrt(mean(y_sim3_data.^2));

z_sim1 = sqrt(mean(z_sim1_data.^2)); 
z_sim2 = sqrt(mean(z_sim2_data.^2)); 
z_sim3 = sqrt(mean(z_sim3_data.^2)); 

% Combine the data into a matrix
data = [
    x_sim1, x_sim2, x_sim3;  % X-axis
    y_sim1, y_sim2, y_sim3;  % Y-axis
    z_sim1, z_sim2, z_sim3   % Z-axis
];

% === Calculate Percentage Reductions  Real ===
percentage_reduction_x = ((x_sim3 - x_sim1) / x_sim3) * 100;
percentage_reduction_y = ((y_sim3 - y_sim1) / y_sim3) * 100;
percentage_reduction_z = ((z_sim3 - z_sim1) / z_sim3) * 100;

percentage_reductions = [percentage_reduction_x, percentage_reduction_y, percentage_reduction_z];

% === Calculate Percentage Reductions  Estimated ===
percentage_reduction_x_hat = ((x_sim3 - x_sim2) / x_sim3) * 100;
percentage_reduction_y_hat = ((y_sim3 - y_sim2) / y_sim3) * 100;
percentage_reduction_z_hat = ((z_sim3 - z_sim2) / z_sim3) * 100;

percentage_reductions_hat = [percentage_reduction_x_hat, percentage_reduction_y_hat, percentage_reduction_z_hat];


% === Plot the Bar Chart ===
figure("WindowState", "maximized");
bar_handle = bar(data); % Create a grouped bar chart

% === Customize the Plot ===
xlabel('Axes', 'FontSize', x_lab, 'FontWeight', 'normal'); 
ylabel('RMSE of position', 'FontSize', y_lab, 'FontWeight', 'normal'); 
legend('Real trajectory', 'Estimated trajectory', ' (Siddiqui et al., 2024)', 'FontSize', 30, 'FontWeight', 'normal', 'Location', 'north');
set(gca, 'XTickLabel', {'X', 'Y', 'Z'}, 'FontSize', gca_fs, 'FontWeight', 'normal'); 
grid off; 
legend('Orientation', 'vertical');
set(legend, 'Interpreter', 'latex');

% === Annotate Percentages Above Bars ===
x_positions = bar_handle(1).XEndPoints; % X positions for "Real trajectory"
y_positions = data(:, 1); % Y values for "Real trajectory"

% Add percentage reductions as annotations
for i = 1:length(percentage_reductions)
    text(x_positions(i), y_positions(i) + 0.02, ... % Slightly above the bar
         sprintf('%.2f%%', percentage_reductions(i)), ... % Add percentage text
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 20, 'FontWeight', 'bold');
end

% === Annotate Percentages Above Bars for Estimated Trajectory ===
x_positions_estimated = bar_handle(2).XEndPoints; % X positions for "Estimated trajectory"
y_positions_estimated = data(:, 2); % Y values for "Estimated trajectory"

% Add percentage reductions as annotations for Estimated trajectory
for i = 1:length(percentage_reductions_hat)
    text(x_positions_estimated(i), y_positions_estimated(i) + 0.02, ... % Slightly above the bar
         sprintf('%.2f%%', percentage_reductions_hat(i)), ... % Add percentage text
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 20, 'FontWeight', 'bold');
end

set(gca, 'FontSize', gca_fs); % Apply font size to axes
saveas(gcf,strcat(figuresdir, 'BAR_chart_Lissa'), 'fig');
saveas(gcf,strcat(figuresdir, 'BAR_chart_Lissa'), 'epsc');
%% Attitude bar char
% === Load Workspace Data ===
x_sim1_data = OFC.attitude_roll_error; 
x_sim2_data = OFC.roll_estimated - OFC.roll_des;
x_sim3_data = SFC.attitude_roll_error;

y_sim1_data = OFC.attitude_pitch_error; 
y_sim2_data = OFC.pitch_estimated - OFC.pitch_des;
y_sim3_data = SFC.attitude_pitch_error;

z_sim1_data = OFC.attitude_yaw_error; 
z_sim2_data = OFC.yaw_estimated - OFC.yaw_des;
z_sim3_data = SFC.attitude_yaw_error;

% === Process the Data ===
x_sim1 = sqrt(mean(x_sim1_data.^2)); 
x_sim2 = sqrt(mean(x_sim2_data.^2)); 
x_sim3 = sqrt(mean(x_sim3_data.^2)); 

y_sim1 = sqrt(mean(y_sim1_data.^2)); 
y_sim2 = sqrt(mean(y_sim2_data.^2)); 
y_sim3 = sqrt(mean(y_sim3_data.^2));

z_sim1 = sqrt(mean(z_sim1_data.^2)); 
z_sim2 = sqrt(mean(z_sim2_data.^2)); 
z_sim3 = sqrt(mean(z_sim3_data.^2)); 

% Combine the data into a matrix
data = [
    x_sim1, x_sim2, x_sim3;  % X-axis
    y_sim1, y_sim2, y_sim3;  % Y-axis
    z_sim1, z_sim2, z_sim3   % Z-axis
];

% === Calculate Percentage Reductions  Real ===
percentage_reduction_x = ((x_sim3 - x_sim1) / x_sim3) * 100;
percentage_reduction_y = ((y_sim3 - y_sim1) / y_sim3) * 100;
percentage_reduction_z = ((z_sim3 - z_sim1) / z_sim3) * 100;

percentage_reductions = [percentage_reduction_x, percentage_reduction_y, percentage_reduction_z];

% === Calculate Percentage Reductions  Estimated ===
percentage_reduction_x_hat = ((x_sim3 - x_sim2) / x_sim3) * 100;
percentage_reduction_y_hat = ((y_sim3 - y_sim2) / y_sim3) * 100;
percentage_reduction_z_hat = ((z_sim3 - z_sim2) / z_sim3) * 100;

percentage_reductions_hat = [percentage_reduction_x_hat, percentage_reduction_y_hat, percentage_reduction_z_hat];


% === Plot the Bar Chart ===
figure("WindowState", "maximized");
bar_handle = bar(data); % Create a grouped bar chart

% === Customize the Plot ===
xlabel('Axes', 'FontSize', x_lab, 'FontWeight', 'normal'); 
ylabel('RMSE of attitude', 'FontSize', y_lab, 'FontWeight', 'normal'); 
legend('Real trajectory', 'Estimated trajectory', ' (Siddiqui et al., 2024)', 'FontSize', 30, 'FontWeight', 'normal', 'Location', 'northeast');
set(gca, 'XTickLabel', {'X', 'Y', 'Z'}, 'FontSize', gca_fs, 'FontWeight', 'normal'); 
grid off; 
legend('Orientation', 'vertical');
set(legend, 'Interpreter', 'latex');

% === Annotate Percentages Above Bars ===
x_positions = bar_handle(1).XEndPoints; % X positions for "Real trajectory"
y_positions = data(:, 1); % Y values for "Real trajectory"

% Add percentage reductions as annotations
for i = 1:length(percentage_reductions)
    text(x_positions(i), y_positions(i) + 0.002, ... % Slightly above the bar
         sprintf('%.2f%%', percentage_reductions(i)), ... % Add percentage text
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 20, 'FontWeight', 'bold');
end

% === Annotate Percentages Above Bars for Estimated Trajectory ===
x_positions_estimated = bar_handle(2).XEndPoints; % X positions for "Estimated trajectory"
y_positions_estimated = data(:, 2); % Y values for "Estimated trajectory"

% Add percentage reductions as annotations for Estimated trajectory
for i = 1:length(percentage_reductions_hat)
    text(x_positions_estimated(i), y_positions_estimated(i) + 0.002, ... % Slightly above the bar
         sprintf('%.2f%%', percentage_reductions_hat(i)), ... % Add percentage text
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 20, 'FontWeight', 'bold');
end

set(gca, 'FontSize', gca_fs); % Apply font size to axes
saveas(gcf,strcat(figuresdir, 'BAR_chart_Lissa_attitude'), 'fig');
saveas(gcf,strcat(figuresdir, 'BAR_chart_Lissa_attitude'), 'epsc');

keyboard
y_lab = 60;
%%    SLICES PLOTS
% poisition

% Load your position error data from Simulink
xError = OFC.pos_x_error; % X errors
yError = OFC.pos_y_error; % Y errors
zError = OFC.pos_z_error; % Z errors

% Generate a grid and interpolate data
gridSize = 50; % Set grid resolution
xRange = linspace(min(xError), max(xError), gridSize);
yRange = linspace(min(yError), max(yError), gridSize);
zRange = linspace(min(zError), max(zError), gridSize);
[X, Y, Z] = meshgrid(xRange, yRange, zRange);

% Create interpolant for error data
errorMagnitudes = sqrt(xError.^2 + yError.^2 + zError.^2); % example definition
F = scatteredInterpolant(xError, yError, zError, errorMagnitudes, 'linear', 'none');
errorGrid = F(X, Y, Z); % Interpolate errors onto the grid

% Define the threshold value
thresholdValue = 1.0; % Example threshold for filtering

% Mask the data: Set values below the threshold to NaN
maskedErrorGrid = errorGrid;
maskedErrorGrid(errorGrid <= thresholdValue) = NaN;

% Slice plot for regions above the threshold
figure("WindowState", "maximized");

% Define slice planes (center slices)
sliceX = mean(xRange); % Center slice in X
sliceY = mean(yRange); % Center slice in Y
sliceZ = mean(zRange); % Center slice in Z

% Create slices using the masked data
s = slice(X, Y, Z, maskedErrorGrid, sliceX, sliceY, sliceZ);

% Set appearance
shading interp; % Smooth shading
colormap(jet);  % Apply colormap
colorbar;       % Add colorbar for reference
xlabel('X'); ylabel('Y'); zlabel('Z');
%title(['Conditional Slices for Errors > ', num2str(thresholdValue)]);
grid off;
box on;
% Optional: Remove edges for smoother appearance
set(s, 'EdgeColor', 'none'); % No edges
%legend('Location','best')
%set(legend,'Interpreter','latex')
%set(gca,'FontSize',36)
ax = gca; % Get current axes handle
ax.LineWidth = 2; % Set the thickness of the box

set(gca,'FontSize',gca_fs)                          % this also effects the number of grid lines [more boxes or less boxes] in 3D plot
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('$\tilde{x}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
ylabel('$\tilde{y}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
zlabel('$\tilde{z}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
box on
saveas(gcf,strcat(figuresdir, 'Slice_chart_Lissa'), 'fig');
saveas(gcf,strcat(figuresdir, 'Slice_chart_Lissa'), 'epsc');

% attitude slice plot
% Load your position error data from Simulink
xError = OFC.attitude_roll_error; % X errors
yError = OFC.attitude_pitch_error; % Y errors
zError = OFC.attitude_yaw_error; % Z errors

% Generate a grid and interpolate data
gridSize = 50; % Set grid resolution
xRange = linspace(min(xError), max(xError), gridSize);
yRange = linspace(min(yError), max(yError), gridSize);
zRange = linspace(min(zError), max(zError), gridSize);
[X, Y, Z] = meshgrid(xRange, yRange, zRange);

% Create interpolant for error data
F = scatteredInterpolant(xError, yError, zError, errorMagnitudes, 'linear', 'none');
errorGrid = F(X, Y, Z); % Interpolate errors onto the grid

% Define the threshold value
thresholdValue = 1.0; % Example threshold for filtering

% Mask the data: Set values below the threshold to NaN
maskedErrorGrid = errorGrid;
maskedErrorGrid(errorGrid <= thresholdValue) = NaN;

% Slice plot for regions above the threshold
figure("WindowState", "maximized");

% Define slice planes (center slices)
sliceX = mean(xRange); % Center slice in X
sliceY = mean(yRange); % Center slice in Y
sliceZ = mean(zRange); % Center slice in Z

% Create slices using the masked data
s = slice(X, Y, Z, maskedErrorGrid, sliceX, sliceY, sliceZ);

% Set appearance
shading interp; % Smooth shading
colormap(jet);  % Apply colormap
colorbar;       % Add colorbar for reference
xlabel('X'); ylabel('Y'); zlabel('Z');
%title(['Conditional Slices for Errors > ', num2str(thresholdValue)]);
grid off;
box on;
% Optional: Remove edges for smoother appearance
set(s, 'EdgeColor', 'none'); % No edges
%legend('Location','best')
%set(legend,'Interpreter','latex')
%set(gca,'FontSize',36)
ax = gca; % Get current axes handle
ax.LineWidth = 2; % Set the thickness of the box

set(gca,'FontSize',gca_fs)                          % this also effects the number of grid lines [more boxes or less boxes] in 3D plot
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('$\tilde{\phi}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
ylabel('$\tilde{\theta}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
zlabel('$\tilde{\psi}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
box on
saveas(gcf,strcat(figuresdir, 'Slice_chart_Lissa_attitude'), 'fig');
saveas(gcf,strcat(figuresdir, 'Slice_chart_Lissa_attitude'), 'epsc');

keyboard
%%  ISO SURFACE PLOTS
% Load your position error data from Simulink
xError = OFC.pos_x_error; % X errors
yError = OFC.pos_y_error; % Y errors
zError = OFC.pos_z_error; % Z errors

% Generate a grid and interpolate data
gridSize = 50; % Set grid resolution
xRange = linspace(min(xError), max(xError), gridSize);
yRange = linspace(min(yError), max(yError), gridSize);
zRange = linspace(min(zError), max(zError), gridSize);
[X, Y, Z] = meshgrid(xRange, yRange, zRange);

% Create interpolant for error data
F = scatteredInterpolant(xError, yError, zError, errorMagnitudes, 'linear', 'none');
errorGrid = F(X, Y, Z); % Interpolate errors onto the grid

% Define the threshold value
thresholdValue = 1.5; % Example threshold for filtering

% Create a binary mask for regions where error is greater than threshold
binaryMask = errorGrid > thresholdValue;

% Use the binary mask for the isosurface
figure("WindowState", "maximized");
isosurface(X, Y, Z, binaryMask, 0.5, errorGrid); % 0.5 is the isovalue for binary mask
colormap(jet); % Apply colormap
colorbar; % Add colorbar for reference
xlabel('X'); ylabel('Y'); zlabel('Z');
%title(['Isosurface for Errors > ', num2str(thresholdValue)]);
grid off;
box on
% Set appearance of the isosurface
h = gca;
view(3); % 3D view
%axis tight; % Tighten the axes
%legend('Location','best')
%set(legend,'Interpreter','latex')
%set(gca,'FontSize',36)
ax = gca; % Get current axes handle
ax.LineWidth = 1.5; % Set the thickness of the box

set(gca,'FontSize',gca_fs)                          % this also effects the number of grid lines [more boxes or less boxes] in 3D plot
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('$\tilde{x}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
ylabel('$\tilde{y}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
zlabel('$\tilde{z}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')

saveas(gcf,strcat(figuresdir, 'Iso_chart_Lissa'), 'fig');
saveas(gcf,strcat(figuresdir, 'Iso_chart_Lissa'), 'epsc');


% attitude

xError = OFC.attitude_roll_error; % X errors
yError = OFC.attitude_pitch_error; % Y errors
zError = OFC.attitude_yaw_error; % Z errors

% Generate a grid and interpolate data
gridSize = 50; % Set grid resolution
xRange = linspace(min(xError), max(xError), gridSize);
yRange = linspace(min(yError), max(yError), gridSize);
zRange = linspace(min(zError), max(zError), gridSize);
[X, Y, Z] = meshgrid(xRange, yRange, zRange);

% Create interpolant for error data
F = scatteredInterpolant(xError, yError, zError, errorMagnitudes, 'linear', 'none');
errorGrid = F(X, Y, Z); % Interpolate errors onto the grid

% Define the threshold value
thresholdValue = 1.5; % Example threshold for filtering

% Create a binary mask for regions where error is greater than threshold
binaryMask = errorGrid > thresholdValue;

% Use the binary mask for the isosurface
figure("WindowState", "maximized");
isosurface(X, Y, Z, binaryMask, 0.5, errorGrid); % 0.5 is the isovalue for binary mask
colormap(jet); % Apply colormap
colorbar; % Add colorbar for reference
xlabel('X'); ylabel('Y'); zlabel('Z');
%title(['Isosurface for Errors > ', num2str(thresholdValue)]);
grid off;
box on
% Set appearance of the isosurface
h = gca;
view(3); % 3D view
%axis tight; % Tighten the axes
%legend('Location','best')
%set(legend,'Interpreter','latex')
%set(gca,'FontSize',36)
ax = gca; % Get current axes handle
ax.LineWidth = 1.5; % Set the thickness of the box

set(gca,'FontSize',gca_fs)                          % this also effects the number of grid lines [more boxes or less boxes] in 3D plot
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('$\tilde{\phi}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
ylabel('$\tilde{\theta}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
zlabel('$\tilde{\psi}(t)$','FontSize',y_lab,'FontWeight','normal','Interpreter','latex')
saveas(gcf,strcat(figuresdir, 'Iso_chart_Lissa_attitude'), 'fig');
saveas(gcf,strcat(figuresdir, 'Iso_chart_Lissa_attitude'), 'epsc');