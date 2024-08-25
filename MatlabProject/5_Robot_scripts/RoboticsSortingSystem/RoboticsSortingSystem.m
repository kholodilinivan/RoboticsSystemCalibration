clc
clear all
name = "Matlab";
Client = TCPInit('127.0.0.1',55001,name);
load('Omni_Calib_Results_116m.mat'); % Calib parameters
ocam_model = calib_data.ocam_model; % Calib parameters
i = calib_data.n_ima;
calib_data.L(i+1)={'TestImages/image.jpg'};
use_corner_find=1;
[callBack,Xp_abs_,Yp_abs_] = ...
    get_checkerboard_cornersUrban(i+1,use_corner_find,calib_data);
Xt = calib_data.Xt;
Yt = calib_data.Yt;
imagePoints = [Yp_abs_,Xp_abs_];
% first image extrinsic
[RRfin,ss]=calibrate(Xt, Yt, Xp_abs_, Yp_abs_, ocam_model);
RRfin_=FindTransformMatrix(Xp_abs_, Yp_abs_, Xt, Yt, ocam_model, RRfin);

%% find distance
X1 = RRfin_(2,3)
Y1 = -RRfin_(1,3)
Z1 = RRfin_(3,3)

%% build map
% Laser Segmentation
image = imread('TestImages/image.jpg')
img = las_segm(image);
% Configuration
camX = 0; % Camera parameters
camY = 0; % Camera parameters
camZ = 0; % Camera parameters
lasX = 1; % Laser Plane parameters
lasY = 2.5; % Laser Plane parameters
las_dist = 950; % Laser Plane parameters
CVsyst_x = 0; % CV System position
CVsyst_y = 0; % CV System position 
Chess_x = X1; % Chess position
Chess_y = Y1; % Chess position 
Robot_x = Chess_x + 100; % Robot position
Robot_y = Chess_y + 500; % Robot position
% Mapping
[x,y] = mapping(img,camX,camY,camZ,lasX,lasY,las_dist,ocam_model); % mapping function
% Finally figure:
figure;
scatter(x,y,5,'filled'); % Laser intersections, first image
hold on;
plot(CVsyst_x,CVsyst_y,'r*'); % CV System location
text(CVsyst_x,CVsyst_y, 'Camera'); % CV System location
plot(Chess_x,Chess_y,'r*'); % Chess location
text(Chess_x,Chess_y, 'Chess'); % Chess location
plot(Robot_x,Robot_y,'r*'); % Robot location
text(Robot_x,Robot_y, 'Robot'); % Robot location
grid on;

%% Distance from robot to black cube
% Black Cube right
i=[485;539]; % working image region - column
j=[521;587]; % working image region - row
[C_left] = cube_dist(img,i,j,camX,camY,camZ,lasX,lasY,las_dist,ocam_model);
C_left_cam = mean(C_left(:,1))-240/2; % distance from camera to black cube
C_left_robot = abs(Robot_x) - abs(C_left_cam) % distance from robot to black cube
% Black Cube bottom
i=[431;500]; % working image region - column
j=[575;629]; % working image region - row
[C_Up] = cube_dist(img,i,j,camX,camY,camZ,lasX,lasY,las_dist,ocam_model);
C_Up_cam = mean(C_Up(:,2))+240/2; % distance from camera to black cube
C_Up_robot = abs(Robot_y) - abs(C_Up_cam) % distance from robot to black cube

%% Calculate Inverse Kinematics                                                                                                                                                                          
x1 = C_left_robot;
y1 = C_Up_robot;
z1 = 200;
[thetha1,thetha2,thetha3,thetha4,thetha5,thetha6] = calculate_ik(x1, y1, z1);
joints = [thetha1*pi/180,thetha2*pi/180,thetha3*pi/180,thetha4*pi/180,thetha5*pi/180,thetha6*pi/180];

%% Calculate trajectory
Tm = 40; % trajectory steps
qi1 = joints; % ik position
qf1 = [0,90*pi/180,0,0,-90*pi/180,0]; % init position
q = (qi1 - qf1) / Tm; % traj points
for a = 1 : 40
    % robot.plot(qf1); % plot traj 
    qf1 = qf1 + q;
    func_data(Client, qf1); % send data to unity
end
% robot.teach(joints);
pause(0.5);

%% take object
grab = 1;
func_grab(Client, grab);% send data to unity
pause(4.5);

%% back to init pos
for a = 1 : 40
    % robot.plot(qf1); % plot traj   
    qf1 = qf1 - q;
    func_data(Client, qf1); % send data to unity
end
pause(0.5);

%% Color detection
color = color_check(Client); % function for detecting colors

if color == 3 % Black sorting
    x2 = 204; 
    y2 = 1413;
    z2 = 200;
else 
    x2 = 0;
    y2 = 0;
    z2 = 0;
end
pause(0.5);

%% Calculate Inverse Kinematics
x1 = x2;
y1 = y2;
z1 = z2;
[thetha1,thetha2,thetha3,thetha4,thetha5,thetha6] = calculate_ik(x1, y1, z1);
joints = [thetha1*pi/180,thetha2*pi/180,thetha3*pi/180,thetha4*pi/180,thetha5*pi/180,thetha6*pi/180];

%% Calculate trajectory
Tm = 40; % trajectory steps
qi1 = joints; % ik position
qf1 = [0,90*pi/180,0,0,-90*pi/180,0]; % init position
q = (qi1 - qf1) / Tm; % traj points
for a = 1 : 40
    % robot.plot(qf1); % plot traj 
    qf1 = qf1 + q;
    func_data(Client, qf1); % send data to unity
end
% robot.teach(joints);
pause(0.5);

%% release object
grab = 0;
func_grab(Client, grab); % send data to unity
pause(0.5);

%% back to init pos
for a = 1 : 40
    % robot.plot(qf1); % plot traj   
    qf1 = qf1 - q;
    func_data(Client, qf1); % send data to unity
end

% Close Gracefully
fprintf(1,"Disconnected from server\n");