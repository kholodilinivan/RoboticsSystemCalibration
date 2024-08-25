% Parol6 Robot arm RTB FK
clc
clear

L1 = 123.32; L2 = 577.32; L3 = 949.04; L4 = 227.79; L5 = 918.09; L6 = 740.36;
% thetha1 = 0; thetha2 = 90; thetha3 = 0; thetha4 = 0; thetha5 = 0; thetha6 = 0;
thetha1 = 30; thetha2 = 15; thetha3 = 120; thetha4 = 5; thetha5 = -60; thetha6 = 10;
alpha1 = 90; alpha2 = 0; alpha3 = 90; alpha4 = 270; alpha5 = 90; alpha6 = 0;
r1 = L1; r2 = L3; r3 = L4; r4 = 0; r5 = 0; r6 = 0; 
d1 = L2; d2 = 0; d3 = 0; d4 = L5; d5 = 0; d6 = L6;

T1 = [cosd(thetha1) -sind(thetha1)*cosd(alpha1) sind(thetha1)*sind(alpha1) r1*cosd(thetha1);
      sind(thetha1) cosd(thetha1)*cosd(alpha1) -cosd(thetha1)*sind(alpha1) r1*sind(thetha1);
      0 sind(alpha1) cosd(alpha1) d1;
      0 0 0 1];
T2 = [cosd(thetha2) -sind(thetha2)*cosd(alpha2) sind(thetha2)*sind(alpha2) r2*cosd(thetha2);
      sind(thetha2) cosd(thetha2)*cosd(alpha2) -cosd(thetha2)*sind(alpha2) r2*sind(thetha2);
      0 sind(alpha2) cosd(alpha2) d2;
      0 0 0 1];
T3 = [cosd(thetha3) -sind(thetha3)*cosd(alpha3) sind(thetha3)*sind(alpha3) r3*cosd(thetha3);
      sind(thetha3) cosd(thetha3)*cosd(alpha3) -cosd(thetha3)*sind(alpha3) r3*sind(thetha3);
      0 sind(alpha3) cosd(alpha3) d3;
      0 0 0 1];
T4 = [cosd(thetha4) -sind(thetha4)*cosd(alpha4) sind(thetha4)*sind(alpha4) r4*cosd(thetha4);
      sind(thetha4) cosd(thetha4)*cosd(alpha4) -cosd(thetha4)*sind(alpha4) r4*sind(thetha4);
      0 sind(alpha4) cosd(alpha4) d4;
      0 0 0 1];
T5 = [cosd(thetha5) -sind(thetha5)*cosd(alpha5) sind(thetha5)*sind(alpha5) r5*cosd(thetha5);
      sind(thetha5) cosd(thetha5)*cosd(alpha5) -cosd(thetha5)*sind(alpha5) r5*sind(thetha5);
      0 sind(alpha5) cosd(alpha5) d5;
      0 0 0 1];
T6 = [cosd(thetha6) -sind(thetha6)*cosd(alpha6) sind(thetha6)*sind(alpha6) r6*cosd(thetha6);
      sind(thetha6) cosd(thetha6)*cosd(alpha6) -cosd(thetha6)*sind(alpha6) r6*sind(thetha6);
      0 sind(alpha6) cosd(alpha6) d6;
      0 0 0 1];

T1*T2*T3*T4*T5*T6
%% Parol6 Robot arm RTB
L1 = 123.32; L2 = 577.32; L3 = 949.04; L4 = 227.79; L5 = 918.09; L6 = 740.36;
% thetha1 = 0; thetha2 = 90; thetha3 = 0; thetha4 = 0; thetha5 = 0; thetha6 = 0;
thetha1 = 30; thetha2 = 15; thetha3 = 120; thetha4 = 5; thetha5 = -60; thetha6 = 10;
alpha1 = 90; alpha2 = 0; alpha3 = 90; alpha4 = 270; alpha5 = 90; alpha6 = 0;
r1 = L1; r2 = L3; r3 = L4; r4 = 0; r5 = 0; r6 = 0; 
d1 = L2; d2 = 0; d3 = 0; d4 = L5; d5 = 0; d6 = L6;

L(1) = Revolute('d',d1,'a',r1,'alpha',alpha1*pi/180);
L(2) = Revolute('d',d2,'a',r2,'alpha',alpha2*pi/180);
L(3) = Revolute('d',d3,'a',r3,'alpha',alpha3*pi/180);
L(4) = Revolute('d',d4,'a',r4,'alpha',alpha4*pi/180);
L(5) = Revolute('d',d5,'a',r5,'alpha',alpha5*pi/180);
L(6) = Revolute('d',d6,'a',r6,'alpha',alpha6*pi/180);
robot = SerialLink(L);
joints = [thetha1*pi/180,thetha2*pi/180,thetha3*pi/180,thetha4*pi/180,thetha5*pi/180,thetha6*pi/180];
robot.plot(joints);
robot.teach(joints);