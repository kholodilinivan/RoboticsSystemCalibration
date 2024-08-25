clc
clear all
% Laser Segmentation
image = imread('TestImages/image.jpg');
img = las_segm(image);
% Mapping
load('Omni_Calib_Results_116m.mat'); % Calib parameters
ocam_model = calib_data.ocam_model; % Calib parameters
x = 1; % Laser Plane parameters
y = 2.5; % Laser Plane parameters
las_dist = 950; % Laser Plane parameters
CVsyst_x = 0; % CV System position
CVsyst_y = 0; % CV System position
[x1,y1] = mapping(img,x,y,las_dist,ocam_model); % mapping function
% Finally figure:
figure;
scatter(x1,y1,5,'filled'); % Laser intersections
hold on;
plot(CVsyst_x,-CVsyst_y,'r*'); % CV System location
grid on;
% Results validation
% Black Cube right
i=[485;539]; % working image region - column
j=[521;587]; % working image region - row
[C_left] = cube_dist(img,i,j,x,y,las_dist,ocam_model);
C_left = mean(C_left(:,1))-240/2;
% Black Cube bottom
i=[431;500]; % working image region - column
j=[575;629]; % working image region - row
[C_Up] = cube_dist(img,i,j,x,y,las_dist,ocam_model);
C_Up = mean(C_Up(:,2))+240/2;