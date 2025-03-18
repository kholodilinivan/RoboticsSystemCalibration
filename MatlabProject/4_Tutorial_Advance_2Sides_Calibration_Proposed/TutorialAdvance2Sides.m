% Parameters from Unity: 
% Camera: X=-3.5, Y=1, Z=2.5 | Laser: X=0.5, Y=2 | Laser Distance = 950
% Initialize
clc
clear all
global ocam_model;
global Cent;
global Cent1;
global cam_pitch_opt;
global cam_roll_opt;
global cam_yaw_opt;
global las_pitch_opt;
global las_roll_opt;
global Cube_width;
load('Omni_Calib_Results_Sim.mat');
ocam_model = calib_data.ocam_model;
%% Border extraction
I1_ = imread('TestImages/image.png'); % read image
BW = BWBorder_(I1_); % extract border between Black & White regions
figure
imshow(~BW);
% extract border for each side of the box
[Cent,Cent1,idx]=border_blobs(BW);
% check whether number of blobs correct or not
if (idx ~= 2)
    clear;
end
% camera calibration
Guess = 1;
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
cam_pitch_opt = fmincon(@objective_pitch_cam,Guess,[],[],[],[],-30,30,...
    @constraint,options);
%
cam_yaw_opt = fmincon(@objective_yaw_cam,Guess,[],[],[],[],-30,30,...
    @constraint,options);
%
cam_roll_opt = fmincon(@objective_roll_cam,Guess,[],[],[],[],-30,30,...
    @constraint,options);
% calib case
[x,y] = mapping_points(Cent,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    0,0,1,ocam_model);
[x1,y1] = mapping_points(Cent1,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    0,0,1,ocam_model);
scatter(x,y,5,'b.'); % border intersections
hold on
scatter(x1,y1,5,'b.'); % border intersections
scatter(0,0,'b*'); % Robot location

% for las
Cent = []; 
Cent1 = []; 
I_ = las_segm(I1_,-80);
[xx_,zz_,idx]=blue_blobs(I_,I1_);
% check whether number of blobs correct or not
if (idx ~= 8)
    clear;
end
% fitting laser points for each side of the target
img1 = las_segm(I1_,138);
img1 = bwmorph(img1,'skel',Inf);
[Cent, Cent1]=intersect_blobs(img1,zz_,xx_); % Cent1,2-h, Cent2,3-v
% laser plane calibration
las_pitch_opt = fmincon(@objective_pitch_las,Guess,[],[],[],[],-30,30,...
    @constraint,options);
las_roll_opt = fmincon(@objective_roll_las,Guess,[],[],[],[],-30,30,...
    @constraint,options);
%%
Cube_width = 1292.4;
las_dist_opt = fmincon(@objective_dist_las,Guess,[],[],[],[],[],[],...
    @constraint,options);

%% test fo paper
[x,y] = mapping_points(Cent,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,las_dist_opt,ocam_model);
[x1,y1] = mapping_points(Cent1,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,las_dist_opt,ocam_model);
scatter(x,y,5,'b.'); % Laser intersections
hold on
scatter(x1,y1,5,'b.'); % Laser intersections
scatter(0,0,'b*'); % Robot location

%% calib case
[x,y] = mapping_points(Cent,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,1,ocam_model);
[x1,y1] = mapping_points(Cent1,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,1,ocam_model);
scatter(x,y,5,'b.'); % Laser intersections
hold on
scatter(x1,y1,5,'b.'); % Laser intersections
scatter(0,0,'b*'); % Robot location

%% calib case
[x,y] = mapping_points(Cent,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,las_dist_opt,ocam_model);
[x1,y1] = mapping_points(Cent1,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,las_dist_opt,ocam_model);
scatter(x,y,5,'b.'); % Laser intersections
hold on
scatter(x1,y1,5,'b.'); % Laser intersections
scatter(0,0,'b*'); % Robot location

%% Results validation (mapping)
clc
image = imread('TestImages/image1.jpg');
img = las_segm(image, 83);
% img = bwmorph(img,'skel',Inf);

[x,y] = mapping(img,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,las_dist_opt,ocam_model);
robot_x = 0; % Robot position
robot_y = 0; % Robot position
figure;
scatter(x,y,5,'filled'); % Laser intersections
hold on;
plot(robot_x,-robot_y,'r*'); % Robot location
grid on;

%% Black Cube right
clc
i=[497;575]; % working image region - column
j=[545;638]; % working image region - row
[Cube_L] = cube_dist(img,i,j,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,las_dist_opt,ocam_model);
Cube_L = mean(Cube_L(:,1))-240/2;
% Black Cube bottom
i=[437;494]; % working image region - column
j=[641;686]; % working image region - row
[Cube_Up] = cube_dist(img,i,j,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    las_roll_opt,las_pitch_opt,las_dist_opt,ocam_model);
Cube_Up = mean(Cube_Up(:,2))+240/2;