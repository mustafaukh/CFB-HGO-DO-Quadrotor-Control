close all

H = figure('Name','Quadrotor position','WindowState','maximized')

subplot(3,2,[1,3,5])
p=plot3(OFC.x_des,OFC.y_des,OFC.z_des,'LineWidth',4,'color', 'r')
hold on
%axis square
plot3(OFC.x,OFC.y,OFC.z,'LineWidth',4,'color', 'g',LineStyle="--")
plot3(SFC.x,SFC.y,SFC.z,'LineWidth',4,'color', 'b',LineStyle=":")
box on
xlabel('X-axis','FontSize',40,'FontWeight','normal')
ylabel('Y-axis','FontSize',40,'FontWeight','normal')
zlabel('Z-axis','FontSize',40,'FontWeight','normal')
plot3(SFC.x(1,1),SFC.y(1,1),SFC.z(1,1),'x','MarkerSize',40,LineWidth=2.5,MarkerFaceColor = [1 0.5 0])
plot3(SFC.x(end),SFC.y(end),SFC.z(end),'x','MarkerSize',40,LineWidth=2.5,MarkerFaceColor = [1 0.5 0])
text(0.2,1.8,0.2,'$\leftarrow x(0)=0, y(0)=2, z(0)=0$','FontSize',24,'Interpreter','latex')
%title('Trajectory tracking','FontSize',30,'FontWeight','normal')
Traj_tracking = legend(' Desired flight trajectory - $ r(t) $',' Control method in this paper  ',' Control method (Siddiqui et al., 2024)','Initial position','Final position','FontSize',22,'FontWeight','normal','NumColumns',1)
Traj_tracking.ItemTokenSize = [60,48];
legend('Location','northeast')
set(legend,'Interpreter','latex')
%set(gca,'FontSize',36)
set(gca,'FontSize',26)                          % this also effects the number of grid lines [more boxes or less boxes] in 3D plot
set(0,'defaultTextInterpreter','latex'); %trying to set the default
grid on
xlabel('X-axis - [m]','FontSize',40,'FontWeight','normal')
ylabel('Y-axis - [m]','FontSize',40,'FontWeight','normal')
zlabel('Z-axis - [m]','FontSize',40,'FontWeight','normal')
%axis square
axis([-1 8 -1 8 -2 18]);
% gridline are of low resolution so apply this code. usually we need it for
% 3D plots where the figures get blur in the latex environment. so we also
% add exportgraphics code for that to obtain high resolution figure as
% coded below. By default the opacity of gridlines is 0.15 it can be of
% maximum 1. so tune according to the requirements.
ax = gca
ax.GridLineStyle = '-'
ax.GridColor = 'k'
ax.GridAlpha = 0.25 % maximum line opacity
set(gca,'linewidth',1.5)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       QUADROTOR Trajectory Tracking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,2,2)
hold on
plot(OFC.time,OFC.x,'color', color_1,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.x_estimated,'color', color_2,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.x,'--','color', color_3,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.x_des,'-.','color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({'Real',  ' (Siddiqui et al., 2024)', 'Desire $x_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 8.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$x(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y position
subplot(3,2,4)
hold on
plot(OFC.time,OFC.y,'color', color_2,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.y_estimated,'color', color_4,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.y,'--','color', color_6,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.y_des,'-.','color', color_1,'LineWidth',lw_size_mini)
x_pos = legend({'Real', ' (Siddiqui et al., 2024)', 'Desire $y_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -2 7.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$y(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z position
%figure('Name','z_position','WindowState','maximized')
subplot(3,2,6)
%title('Position along z-axis','Interpreter','Latex')
%nexttile
hold on
plot(OFC.time,OFC.z,'color', color_1,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.z_estimated,'color', color_4,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.z,'--','color', color_7,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.z_des,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Real',  ' (Siddiqui et al., 2024)', 'Desire $z_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 22])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$z(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
exportgraphics(H,'Trajectory_tracking_HD_plot_aeat_R2.eps','Resolution',600)
% set painters for 3d plots but it doesnt have transparency i.e. when two
% plots are plotted together then the dotted plot is not visibile.
% therefore in this scenario use exportgraphics which works better 
saveas(gcf,strcat(figuresdir, 'Trajectory_tracking_HD_plot_aeat_R2'), 'fig');
set(gcf,'renderer','Painters')
saveas(gcf,strcat(figuresdir, 'Trajectory_tracking_HD_plot_aeat_R2'), 'epsc');

keyboard

%%
% Define different line styles
lineStyles = {'-', '--', ':', '-.'};

figure('Name','Control inputs','WindowState','maximized');

% Common dimensions for all axes
w = 0.38;  % width
h = 0.38;  % height
y_top = 0.55;
y_bottom = 0.08;
x_left = 0.09;
x_right = 0.55;
x_center = 0.32;

% === Top Left: Torque Inputs ===
ax1 = axes('Position', [x_left, y_top, w, h]);
hold on
plot(OFC.time, OFC.torque_1, 'color', color_1, 'LineStyle', lineStyles{1}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.torque_2, 'color', color_2, 'LineStyle', lineStyles{2}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.torque_3, 'color', color_3, 'LineStyle', lineStyles{3}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.torque_4, 'color', color_4, 'LineStyle', lineStyles{4}, 'LineWidth', lw_size_mini)
x_pos = legend({'$\tau_1 (t)$','$\tau_2 (t)$','$\tau_3 (t)$','$\tau_4 (t)$'}, ...
               'FontSize', legend_fs_mini, 'Location', 'northeast', 'Orientation', 'vertical');
x_pos.ItemTokenSize = [a_len_mini, b_len_mini];
set(x_pos, 'Interpreter', 'latex')
xlabel('Time (sec)', 'FontSize', x_lab_mini)
ylabel('$\tau_i(t)$', 'Interpreter', 'latex', 'FontSize', y_lab_mini)
set(gca, 'FontSize', gca_fs_mini)
box on; grid on; hold off

% === Top Right: Force Inputs ===
ax2 = axes('Position', [x_right, y_top, w, h]);
hold on
plot(OFC.time, OFC.force_1, 'color', color_5, 'LineStyle', lineStyles{1}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.force_2, 'color', color_6, 'LineStyle', lineStyles{2}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.force_3, 'color', color_7, 'LineStyle', lineStyles{3}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.force_4, 'color', color_8, 'LineStyle', lineStyles{4}, 'LineWidth', lw_size_mini)
x_pos = legend({'$f_1 (t)$','$f_2 (t)$','$f_3 (t)$','$f_4 (t)$'}, ...
               'FontSize', legend_fs_mini, 'Location', 'northeast', 'Orientation', 'vertical');
x_pos.ItemTokenSize = [a_len_mini, b_len_mini];
set(x_pos, 'Interpreter', 'latex')
xlabel('Time (sec)', 'FontSize', x_lab_mini)
ylabel('$f_i(t)$', 'Interpreter', 'latex', 'FontSize', y_lab_mini)
set(gca, 'FontSize', gca_fs_mini)
box on; grid on; hold off

% === Bottom Center: Virtual Control Inputs ===
ax3 = axes('Position', [x_center, y_bottom, w, h]);
hold on
plot(OFC.time, OFC.Ux, 'color', color_5, 'LineStyle', lineStyles{1}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.Uy, 'color', color_6, 'LineStyle', lineStyles{2}, 'LineWidth', lw_size_mini)
plot(OFC.time, OFC.Uz, 'color', color_7, 'LineStyle', lineStyles{3}, 'LineWidth', lw_size_mini)
x_pos = legend({'$U_x(t)$','$U_y(t)$','$U_z(t)$'}, ...
               'FontSize', legend_fs_mini, 'Location', 'northeast', 'Orientation', 'vertical');
x_pos.ItemTokenSize = [a_len_mini, b_len_mini];
set(x_pos, 'Interpreter', 'latex')
xlabel('Time (sec)', 'FontSize', x_lab_mini)
ylabel('$U_i(t)$', 'Interpreter', 'latex', 'FontSize', y_lab_mini)
set(gca, 'FontSize', gca_fs_mini)
box on; grid on; hold off

% === Save the Figure ===
saveas(gcf, fullfile(figuresdir, 'Force_torque'), 'fig');
saveas(gcf, fullfile(figuresdir, 'Force_torque'), 'epsc');



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       QUADROTOR CONTROL INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','Control inputs','WindowState','maximized')
%t = tiledlayout(3,2,'TileSpacing','none');
t = tiledlayout(2,2,'TileSpacing','Compact');
%subplot(3,2,1)
nexttile
hold on
plot(OFC.time,OFC.U1,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.U1,'--','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({' Position control  ', ' Position control  - [34]', '  $x (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
%axis([0 simtime 0 8.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$U_p (t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Attitude plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roll
%figure('Name','Attitude_roll','WindowState','maximized')
%subplot(3,2,2)
nexttile
%title('Position along X-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.U2,'color', color_2,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.U2,'--','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({' Roll control input', ' Roll control input - [34]', '  $x (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
%axis([0 simtime -0.5 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$U_\phi(t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y position
%figure('Name','y_position','WindowState','maximized')
%title('Position along y-axis','Interpreter','Latex')
%subplot(3,2,3)
nexttile
hold on
plot(OFC.time,OFC.U3,'color', color_3,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.U3,'--','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({' Pitch control input', ' Pitch control input - [34]', '  $x (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
%axis([0 simtime -2 7])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$U_\theta (t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pitch
%figure('Name','Attitude_pitch','WindowState','maximized')
%subplot(3,2,4)
nexttile
%title('Position along y-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.U4,'color', color_4,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.U4,'--','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({' Yaw control input', ' Yaw control input - [34]', '  $x (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
%axis([0 simtime -1.85 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$U_\psi (t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'Control_inputs'), 'fig');
saveas(gcf,strcat(figuresdir, 'Control_inputs'), 'epsc');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       Estimated Attitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','QUADROTOR Attitude','WindowState','maximized')
axis equal
%t = tiledlayout(3,2,'TileSpacing','none');
t = tiledlayout(2,2,'TileSpacing','Compact');
% Roll
%figure('Name','Attitude_roll','WindowState','maximized')
%subplot(3,2,2)
nexttile
%title('Position along X-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.roll,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.roll_estimated,'--','color', color_2,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.commanded_roll,'--','color', color_3,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.roll_des,'-.','color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated','Commanded', 'Desire $\phi_{r}(t) $'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
axis([0 simtime -0.5 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\phi(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pitch
%figure('Name','Attitude_pitch','WindowState','maximized')
%subplot(3,2,4)
nexttile
%title('Position along y-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.pitch,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pitch_estimated,'--','color', color_3,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.commanded_pitch,'--','color', color_5,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.pitch_des,'-.','color', color_7,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', ' Desire $\theta_{r}(t) $'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
axis([0 simtime -1.85 1.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\theta(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Yaw
%figure('Name','Attitude_yaw','WindowState','maximized')
%subplot(3,2,6)
nexttile
%title('Position along z-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.yaw,'color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.yaw_estimated,'--','color', color_5,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.commanded_yaw,'--','color', color_1,'LineWidth',lw_size_mini)
%yline(yaw_des,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', ' Desire $\psi_{r}(t) $'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
axis([0 simtime 0 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\psi(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tracking errors attitude
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.roll-OFC.roll_estimated,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pitch-OFC.pitch_estimated,'--','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.yaw-OFC.yaw_estimated,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Tracking error: $\tilde{\phi}(t)$','Tracking error: $\tilde{\theta}(t)$', 'Tracking error: $\tilde{\psi}(t)$'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
%axis([0 simtime 2 0])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$[\tilde{\phi}(t), \tilde{\theta}(t), \tilde{\psi}(t)]$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'State_est_Attitude_and_error'), 'fig');
saveas(gcf,strcat(figuresdir, 'State_est_Attitude_and_error'), 'epsc');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       Estimated  Position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','QUADROTOR OUTPUTS','WindowState','maximized')
%t = tiledlayout(3,2,'TileSpacing','none');
t = tiledlayout(2,2,'TileSpacing','Compact');
%subplot(3,2,1)
nexttile
hold on
plot(OFC.time,OFC.x,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.x_estimated,'--','color', color_2,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.commanded_x,'--','color', color_3,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.x_des,'-.','color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', 'Desire $x_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 8.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$x(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y position
%figure('Name','y_position','WindowState','maximized')
%title('Position along y-axis','Interpreter','Latex')
%subplot(3,2,3)
nexttile
hold on
plot(OFC.time,OFC.y,'color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.y_estimated,'--','color', color_4,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.commanded_y,'--','color', color_6,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.y_des,'-.','color', color_1,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated','Commanded', 'Desire $y_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -2 7.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$y(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.z,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.z_estimated,'--','color', color_4,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.commanded_z,'--','color', color_7,'LineWidth',lw_size_mini)
%plot(OFC.time,OFC.z_des,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', 'Desire $z_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 22])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$z(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tracking errors position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.x-OFC.x_estimated,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.y-OFC.y_estimated,'--','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.z-OFC.z_estimated,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Tracking error: $\tilde{x}(t)$','Tracking error: $\tilde{y}(t)$', 'Tracking error: $\tilde{z}(t)$'},'FontSize',legend_fs_mini,'Location','east')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
%axis([0 simtime 2 0])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$[\tilde{x}(t), \tilde{y}(t), \tilde{z}(t)]$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'State_est_Position_and_Error'), 'fig');
saveas(gcf,strcat(figuresdir, 'State_est_Position_and_Error'), 'epsc');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                    Disturbance Observer Attitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','Disturbance Observer','WindowState','maximized')
t2 = tiledlayout(2,2,'TileSpacing','Compact');

% Roll
%figure('Name','Attitude_roll','WindowState','maximized')
%subplot(3,2,2)
nexttile
%title('Position along X-axis','Interpreter','Latex')
hold on
plot(OFC.roll_DO,'color', color_4,'LineWidth',lw_size_mini)
%plot(SFC.roll_DO,'--','color', color_5,'LineWidth',lw_size_mini)
plot(OFC.roll_dist,'-.','color', color_6,'LineWidth',lw_size_mini)
x_pos = legend({'Estimated disturbance: $\hat{d}_\phi (t)$', 'Real disturbance: $d_\phi (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -1 2.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\hat{d}_\phi (t)$ ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pitch
%figure('Name','Attitude_pitch','WindowState','maximized')
%subplot(3,2,4)
nexttile
%title('Position along y-axis','Interpreter','Latex')
hold on
plot(OFC.pitch_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.pitch_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.pitch_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Estimated disturbance: $\hat{d}_\theta (t)$', 'Real disturbance: $d_\theta (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -0.6 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\hat{d}_\theta(t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Yaw
%figure('Name','Attitude_yaw','WindowState','maximized')
%subplot(3,2,6)
nexttile
%title('Position along z-axis','Interpreter','Latex')
hold on
plot(OFC.yaw_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.yaw_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.yaw_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Estimated disturbance: $\hat{d}_\psi (t)$', 'Real disturbance: $d_\psi (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -0.75 1.25])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\hat{d}_\psi(t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tracking errors attitude
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.DO_roll_error,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.DO_pitch_error,'--','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.DO_yaw_error,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance estimation error: $\tilde{d}_\phi (t)$','Disturbance estimation error: $\tilde{d}_\theta (t)$', 'Disturbance estimation error: $\tilde{d}_\psi (t)$'},'FontSize',legend_fs_mini,'Location','south')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
%axis([0 simtime 2 0])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$[\tilde{d}_\phi(t), \tilde{d}_\theta(t), \tilde{d}_\psi(t)]$','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'DO_Attitude'), 'fig');
saveas(gcf,strcat(figuresdir, 'DO_Attitude'), 'epsc');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                    Disturbance Observer Position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','Disturbance Observer','WindowState','maximized')
t2 = tiledlayout(2,2,'TileSpacing','Compact');
%subplot(3,2,1)
nexttile
hold on
plot(OFC.time,OFC.pos_x_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.pos_x_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_x_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Estimated disturbance:   $\hat{d}_{x}(t)$', 'Real disturbance: $d_x(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -2.2 1.75])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\hat{d}_x (t)$ ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y position
%figure('Name','y_position','WindowState','maximized')
%title('Position along y-axis','Interpreter','Latex')
%subplot(3,2,3)
nexttile
hold on
plot(OFC.time,OFC.pos_y_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.pos_y_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_y_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Estimated disturbance:   $\hat{d}_{y}(t)$', 'Real disturbance: $d_y (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -2.25 3])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\hat{d}_y (t)$ ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.pos_z_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.pos_z_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_z_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Estimated disturbance:   $\hat{d}_{z}(t)$', 'Real disturbance: $d_z (t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -1 3])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\hat{d}_z (t)$ ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tracking errors position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.pos_x_dist-OFC.pos_x_DO,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_y_dist-OFC.pos_y_DO,'--','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_z_dist-OFC.pos_z_DO,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance estimation error: $\tilde{d}_x(t)$','Disturbance estimation error: $\tilde{d}_y(t)$', 'Disturbance estimation error: $\tilde{d}_z(t)$'},'FontSize',legend_fs_mini,'Location','east')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
%axis([0 simtime 2 0])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$[\tilde{d}_x(t), \tilde{d}_y(t), \tilde{d}_z(t)]$ ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'DO_Position'), 'fig');
saveas(gcf,strcat(figuresdir, 'DO_Position'), 'epsc');


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       QUADROTOR Attitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','QUADROTOR Attitude','WindowState','maximized')
axis equal
%t = tiledlayout(3,2,'TileSpacing','none');
t = tiledlayout(2,2,'TileSpacing','Compact');
% Roll
%figure('Name','Attitude_roll','WindowState','maximized')
%subplot(3,2,2)
nexttile
%title('Position along X-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.roll,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.roll_estimated,':','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.commanded_roll,'--','color', color_3,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.roll_des,'-.','color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated','Commanded', 'Desire $\phi_{r}(t) $'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
axis([0 simtime -0.5 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\phi(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pitch
%figure('Name','Attitude_pitch','WindowState','maximized')
%subplot(3,2,4)
nexttile
%title('Position along y-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.pitch,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pitch_estimated,':','color', color_3,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.commanded_pitch,'--','color', color_5,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pitch_des,'-.','color', color_7,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', ' Desire $\theta_{r}(t) $'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
axis([0 simtime -1.85 1.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\theta(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Yaw
%figure('Name','Attitude_yaw','WindowState','maximized')
%subplot(3,2,6)
nexttile
%title('Position along z-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.yaw,'color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.yaw_estimated,':','color', color_5,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.commanded_yaw,'--','color', color_1,'LineWidth',lw_size_mini)
yline(yaw_des,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', ' Desire $\psi_{r}(t) $'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
axis([0 simtime 0 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\psi(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tracking errors attitude
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.attitude_roll_error,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.attitude_pitch_error,'--','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.attitude_yaw_error,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Tracking error: $\tilde{\phi}(t)$','Tracking error: $\tilde{\theta}(t)$', 'Tracking error: $\tilde{\psi}(t)$'},'FontSize',legend_fs_mini,'Location','northeast')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
%axis([0 simtime 2 0])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$[\tilde{\phi}(t), \tilde{\theta}(t), \tilde{\psi}(t)]$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'Attitude_and_error'), 'fig');
saveas(gcf,strcat(figuresdir, 'Attitude_and_error'), 'epsc');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       QUADROTOR Position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','QUADROTOR OUTPUTS','WindowState','maximized')
%t = tiledlayout(3,2,'TileSpacing','none');
t = tiledlayout(2,2,'TileSpacing','Compact');
%subplot(3,2,1)
nexttile
hold on
plot(OFC.time,OFC.x,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.x_estimated,':','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.commanded_x,'--','color', color_3,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.x_des,'-.','color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', 'Desire $x_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 8.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$x(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y position
%figure('Name','y_position','WindowState','maximized')
%title('Position along y-axis','Interpreter','Latex')
%subplot(3,2,3)
nexttile
hold on
plot(OFC.time,OFC.y,'color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.y_estimated,':','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.commanded_y,'--','color', color_6,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.y_des,'-.','color', color_1,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated','Commanded', 'Desire $y_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -2 7.5])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$y(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.z,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.z_estimated,':','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.commanded_z,'--','color', color_7,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.z_des,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', 'Commanded', 'Desire $z_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 22])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$z(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tracking errors position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.pos_x_error,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_y_error,'--','color', color_4,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_z_error,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Tracking error: $\tilde{x}(t)$','Tracking error: $\tilde{y}(t)$', 'Tracking error: $\tilde{z}(t)$'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','vertical')
set(legend,'Interpreter','latex')
%axis([0 simtime 2 0])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$[\tilde{x}(t), \tilde{y}(t), \tilde{z}(t)]$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'Position_and_Error'), 'fig');
saveas(gcf,strcat(figuresdir, 'Position_and_Error'), 'epsc');

