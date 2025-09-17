

%%
g = 9.81;                % Gravity                    [m/sec^2]     
m = 0.650;               % Mass                       [kg]     
l = 0.23;                % Length                     [m]
k = 2.980e-6;            %
b = 3.13e-5;             % Thrust coefficient         [N.sec^2]
d = 7.5e-7;              % Drag coefficient           [Nm.sec^2]
R_rad = 0.15;            % Properller radius          [m]
c1 = 0.04;                % Properller chord           [m]
Jr = 6e-5;               % Rotor inertia              [kg.m^2]

Im = 3.357e-5;           %
Ixx = 7.5e-3;            % Inertia on x-axis          [kg.m^2]
Iyy = 7.5e-3;            % Inertia on y-axis          [kg.m^2]
Izz = 1.3e-2;            % Inertia on z-axis          [kg.m^2]

Omega_r = 1;             % Residual angular speed of propeller     [rad.sec]
% Parameters simplification
a1 = (Iyy-Izz)/Ixx;
a2 = Jr/Ixx;
b1 = l/Ixx;

a3 = (Izz-Ixx)/Iyy;
a4 = Jr/Iyy;
b2 = l/Iyy;

a5 = (Ixx-Iyy)/Izz;
b3 = l/Izz;

%% Initial gains
init_cond_roll = 0;
init_cond_pitch = 0;
init_cond_yaw = 0;

init_cond_x = 0;
init_cond_y = 2;
init_cond_z = 0;

%%
roll_des = 0;
pitch_des = 0;
yaw_des = pi/6;  % DESIRED YAW ANGLE
% 
psi_des = yaw_des;

%% Disturbance
roll_dist = 1;
pitch_dist = 0.15;
yaw_dist = 0.20;
%% Control parameters

tau = 0.1; % can be 0.01 but sims run slowly
%% control params STATE FEEDBACK - OFC

% attitude 
x = 30; % low-> smooth. high-> fast and overshoot [attitude control]
y = 30; % low-> fast convergence. high-> slow convergence [attitude control]

z = 0.25;
w = 4;
% attitude gains
SFC_p1_phi = 100;        % 20
SFC_p1_theta = 100;      % 20    
SFC_p1_psi = 1;         % 1

SFC_p2_phi = 120;
SFC_p2_theta = 120;
SFC_p2_psi = 1;

% Position gains
SFC_p1_x = 10;   % 0.00010
SFC_p1_y = 10;   % 0.00010
SFC_p1_z = 10;        % 10

SFC_p2_x = 5;      % 0.65
SFC_p2_y = 5;       % 0.5
SFC_p2_z = 1;         % 2
% DO gains
SFC_zxc = 200;
SFC_lambda = SFC_zxc;

SFC_lamda_phi = SFC_zxc;
SFC_lamda_theta = SFC_zxc;
SFC_lamda_psi = SFC_zxc;
% altitude

%% CONTROL PARAMS OUTPUT FEEDBACK OFC
%% attitude gains
% attitude gains
p1_phi = 20;        % 20
p1_theta = 20;      % 20    
p1_psi = 20;         % 1

p2_phi = 5;
p2_theta = 5;
p2_psi = 5;
  
% Position gains
p1_x = 2;   % 0.00010
p1_y = 2;   % 0.00010
p1_z = 2;        % 10

p2_x = 2;      % 0.65
p2_y = 2;       % 0.5
p2_z = 2;         % 2
% DO gains
zxc = 10;
lambda = zxc;

lamda_phi = zxc;
lamda_theta = zxc;
lamda_psi = zxc;
lambda_x = 2;
lambda_y = 2;
lambda_z = 2;
% HGO
epsi = 0.00001; %0.0001

a1_r = 1;
a2_r = 2;

a1_y = 1;
a2_y = 2;

a1_p = 1;
a2_p = 2;

% pos
a1_x = 1;
a2_x = 2;

a1_y = 1;
a2_y = 2;

a1_z = 1;
a2_z = 2;

% Comm fil
r1 = 1;
r2 = 0.1;

r1_att = 1;
r2_att = 1;
%%                      COLOR CODES FOR PLOTTING
%https://www.mathworks.com/help/matlab/ref/plot.html
color_1 = [0 0.4470 0.7410]; % Metalic blue
color_2 = [0.8500 0.3250 0.0980]; % metalic brown
color_3 = [0.9290 0.6940 0.1250]; % metalic yellow
color_4 = [0.4940 0.1840 0.5560]; % metalic purple
color_5 = [0.4660 0.6740 0.1880]; % metalic green
color_6 = [0.6350 0.0780 0.1840]; % maroon
% % % %
color_7 = [1 0 0];                % Red
color_8 = [1 1 0];                % Yellow
color_9 = [0 1 0];                % Green
color_10 = [0 0 1];                % Blue
color_11 = [0.3010 0.7450 0.9330]; % sky blue
 
% font size of legends, linewidth etc
%
legend_fs = 40;             %legend font size [44]
a_len = 115;                % legend line length - horizontal [Itemtokensize] [70]
b_len = 60;                 % legend line width [Itemtokensize] [48]
gca_fs = 44;                % GCA font size [44]
x_lab = 48;                 % xlabel [48]
y_lab = 48;                 % ylabel [48]
lw_size = 8;                %linewidth [8]
% for subplot
legend_fs_mini = 18;             % legend font size [44]
a_len_mini = 35;                 % legend line length - horizontal [Itemtokensize] [70]
b_len_mini = 48;                 % legend line width [Itemtokensize] [48]
gca_fs_mini = 20;                % GCA font size [44]
x_lab_mini = 18;                 % xlabel [48]
y_lab_mini = 24;                 % ylabel [48]
lw_size_mini = 4;                % linewidth [8]
%%                      DIRECTORIES TO SAVE RESULTS
figuresdir = 'C:\Users\Nigar\Desktop\MUSTAFA_paper\'
%% SIMULATIONS
simtime = 120;
sample_time_roll = 15;
sample_time_pitch = 15;
sample_time_yaw = 1;


OFC = sim('simsss.slx');
SFC = sim('SFC_simulations.slx') ;

keyboard 

H = figure('Name','Quadrotor position','WindowState','maximized')

%subplot(3,2,[1,3,5])
p=plot3(OFC.x_des,OFC.y_des,OFC.z_des,'LineWidth',4,'color', 'r')
hold on
axis square
plot3(OFC.x,OFC.y,OFC.z,'LineWidth',4,'color', 'g',LineStyle="--")
plot3(SFC.x,SFC.y,SFC.z,'LineWidth',4,'color', 'b',LineStyle=":")
xlabel('X-axis','FontSize',40,'FontWeight','normal')
ylabel('Y-axis','FontSize',40,'FontWeight','normal')
zlabel('Z-axis','FontSize',40,'FontWeight','normal')
plot3(SFC.x(1,1),SFC.y(1,1),SFC.z(1,1),'x','MarkerSize',40,LineWidth=2.5,MarkerFaceColor = [1 0.5 0])
plot3(SFC.x(end),SFC.y(end),SFC.z(end),'x','MarkerSize',40,LineWidth=2.5,MarkerFaceColor = [1 0.5 0])
text(0.2,0.2,0.2,'$\leftarrow x(0)=0, y(0)=2, z(0)=0$','FontSize',18,'Interpreter','latex')
%title('Trajectory tracking','FontSize',30,'FontWeight','normal')
Traj_tracking = legend(' Desired flight trajectory - $ r(t) $',' Control method in this paper  ',' Control method (Siddiqui et al., 2024)','Initial position','Final position','FontSize',22,'FontWeight','normal','NumColumns',1)
Traj_tracking.ItemTokenSize = [60,48];
legend('Location','northeast')
set(legend,'Interpreter','latex')
%set(gca,'FontSize',36)
set(gca,'FontSize',gca_fs)                          % this also effects the number of grid lines [more boxes or less boxes] in 3D plot
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('X-axis - [m]','FontSize',40,'FontWeight','normal')
ylabel('Y-axis - [m]','FontSize',40,'FontWeight','normal')
zlabel('Z-axis - [m]','FontSize',40,'FontWeight','normal')
%axis square
axis([-1 8 -1 8 -2 15]);

box on
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
grid on
hold off

exportgraphics(H,'Trajectory_tracking_HD_plot_aeat_v2.eps','Resolution',600)
% set painters for 3d plots but it doesnt have transparency i.e. when two
% plots are plotted together then the dotted plot is not visibile.
% therefore in this scenario use exportgraphics which works better 
saveas(gcf,strcat(figuresdir, 'Trajectory_tracking_HD_plot_aeat_v2'), 'fig');
set(gcf,'renderer','Painters')
saveas(gcf,strcat(figuresdir, 'Trajectory_tracking_HD_plot_aeat_v2'), 'epsc');


%OFC = SFC;
%SFC = SFC;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       QUADROTOR OUTPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','QUADROTOR OUTPUTS','WindowState','maximized')
axis equal
%t = tiledlayout(3,2,'TileSpacing','none');
t = tiledlayout(3,2,'TileSpacing','Compact');
%subplot(3,2,1)
nexttile
hold on
plot(OFC.time,OFC.x,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.x_estimated,'color', color_2,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.x,'--','color', color_3,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.x_des,'-.','color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', ' (Siddiqui et al., 2024)', 'Desire $x_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
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
%Attitude plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roll
%figure('Name','Attitude_roll','WindowState','maximized')
%subplot(3,2,2)
nexttile
%title('Position along X-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.roll,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.roll_estimated,'color', color_2,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.roll,'--','color', color_3,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.roll_des,'-.','color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated',' (Siddiqui et al., 2024)', 'Desire $\phi_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
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
% y position
%figure('Name','y_position','WindowState','maximized')
%title('Position along y-axis','Interpreter','Latex')
%subplot(3,2,3)
nexttile
hold on
plot(OFC.time,OFC.y,'color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.y_estimated,'color', color_4,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.y,'--','color', color_6,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.y_des,'-.','color', color_1,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated',' (Siddiqui et al., 2024)', 'Desire $y_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
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
% Pitch
%figure('Name','Attitude_pitch','WindowState','maximized')
%subplot(3,2,4)
nexttile
%title('Position along y-axis','Interpreter','Latex')
hold on
plot(OFC.time,OFC.pitch,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pitch_estimated,'color', color_3,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.pitch,'--','color', color_5,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pitch_des,'-.','color', color_7,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', ' (Siddiqui et al., 2024)', ' Desire $\theta_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime -1.85 1])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\theta(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
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
plot(OFC.time,OFC.z_estimated,'color', color_4,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.z,'--','color', color_7,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.z_des,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', ' (Siddiqui et al., 2024)', 'Desire $z_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 45])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$z(t)$ - [m]','FontSize',y_lab_mini,'FontWeight','normal' )
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
plot(OFC.time,OFC.yaw_estimated,'color', color_5,'LineWidth',lw_size_mini)
plot(SFC.time,SFC.yaw,'--','color', color_1,'LineWidth',lw_size_mini)
yline(yaw_des,'-.','color', color_2,'LineWidth',lw_size_mini)
x_pos = legend({'Real','Estimated', ' (Siddiqui et al., 2024)', ' Desire $\psi_{r}(t) $'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
axis([0 simtime 0 0.85])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\psi(t)$ - [rad]','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'Attitude_and_Position'), 'fig');
saveas(gcf,strcat(figuresdir, 'Attitude_and_Position'), 'epsc');


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       Disturbance Observer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','Disturbance Observer','WindowState','maximized')
%t = tiledlayout(3,2,'TileSpacing','none');
t2 = tiledlayout(3,2,'TileSpacing','Compact');
%subplot(3,2,1)
nexttile
hold on
plot(OFC.time,OFC.pos_x_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.pos_x_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_x_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance observer: Pos $x(t)$', 'Disturbance $d_x(t) $'},'FontSize',legend_fs_mini,'Location','north')
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
%Attitude plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roll
%figure('Name','Attitude_roll','WindowState','maximized')
%subplot(3,2,2)
nexttile
%title('Position along X-axis','Interpreter','Latex')
hold on
plot(OFC.roll_DO,'color', color_4,'LineWidth',lw_size_mini)
%plot(SFC.roll_DO,'--','color', color_5,'LineWidth',lw_size_mini)
plot(OFC.roll_dist,'-.','color', color_6,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance observer: Roll', 'Disturbance $d_\phi (t) $'},'FontSize',legend_fs_mini,'Location','north')
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
% y position
%figure('Name','y_position','WindowState','maximized')
%title('Position along y-axis','Interpreter','Latex')
%subplot(3,2,3)
nexttile
hold on
plot(OFC.time,OFC.pos_y_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.pos_y_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_y_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance observer: Pos $y(t)$', 'Disturbance $d_y (t) $'},'FontSize',legend_fs_mini,'Location','north')
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
% Pitch
%figure('Name','Attitude_pitch','WindowState','maximized')
%subplot(3,2,4)
nexttile
%title('Position along y-axis','Interpreter','Latex')
hold on
plot(OFC.pitch_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.pitch_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.pitch_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance observer: Pitch', ' Disturbance $d_\theta (t) $'},'FontSize',legend_fs_mini,'Location','north')
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
% z position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.pos_z_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.time,SFC.pos_z_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.pos_z_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance observer: Pos $z(t)$', 'Disturbance $d_z (t) $'},'FontSize',legend_fs_mini,'Location','north')
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
% Yaw
%figure('Name','Attitude_yaw','WindowState','maximized')
%subplot(3,2,6)
nexttile
%title('Position along z-axis','Interpreter','Latex')
hold on
plot(OFC.yaw_DO,'color', color_1,'LineWidth',lw_size_mini)
%plot(SFC.yaw_DO,'--','color', color_2,'LineWidth',lw_size_mini)
plot(OFC.yaw_dist,'-.','color', color_3,'LineWidth',lw_size_mini)
x_pos = legend({'Disturbance observer: Yaw', ' Disturbance $d_\psi (t) $'},'FontSize',legend_fs_mini,'Location','north')
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
saveas(gcf,strcat(figuresdir, 'DO_Attitude_and_Position'), 'fig');
saveas(gcf,strcat(figuresdir, 'DO_Attitude_and_Position'), 'epsc');



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                       QUADROTOR CONTROL INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x position
figure('Name','Control inputs','WindowState','maximized')
%t = tiledlayout(3,2,'TileSpacing','none');
t = tiledlayout(3,2,'TileSpacing','Compact');
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z position
%figure('Name','z_position','WindowState','maximized')
%subplot(3,2,5)
%title('Position along z-axis','Interpreter','Latex')
nexttile
hold on
plot(OFC.time,OFC.torque_1,'color', color_1,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.torque_2,'color', color_2,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.torque_3,'color', color_3,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.torque_4,'color', color_4,'LineWidth',lw_size_mini)
x_pos = legend({' $\tau_1 (t)$','$\tau_2 (t)$','$\tau_3 (t)$', '$\tau_4 (t)$'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
%axis([0 simtime 0 10])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$\tau_i (t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
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
plot(OFC.time,OFC.force_1,'color', color_5,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.force_2,'color', color_6,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.force_3,'color', color_7,'LineWidth',lw_size_mini)
plot(OFC.time,OFC.force_4,'color', color_8,'LineWidth',lw_size_mini)
x_pos = legend({' $f_1 (t)$','$f_2 (t)$','$f_3 (t)$', '$f_4 (t)$'},'FontSize',legend_fs_mini,'Location','north')
x_pos.ItemTokenSize = [a_len_mini,b_len_mini];
legend('Orientation','horizontal')
set(legend,'Interpreter','latex')
%axis([0 simtime 0 25])
set(gca,'FontSize',gca_fs_mini)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
xlabel('Time (sec)','FontSize',x_lab_mini,'FontWeight','normal' )
ylabel('$f_i (t)$  ','FontSize',y_lab_mini,'FontWeight','normal' )
box on
grid on
hold off
saveas(gcf,strcat(figuresdir, 'Control_inputs'), 'fig');
saveas(gcf,strcat(figuresdir, 'Control_inputs'), 'epsc');