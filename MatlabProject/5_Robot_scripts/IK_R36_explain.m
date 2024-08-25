% R36
clc
clear
L4 = 227.79; L5 = 918.09; L6 = 740.36;
alpha4 = 270; alpha5 = 90; alpha6 = 0;
r4 = 0; r5 = 0; r6 = 0; 
d4 = L5; d5 = 0; d6 = L6;

syms R4 R5 R6 R36 thetha4 thetha5 thetha6

R4 = [cos(thetha4) -sin(thetha4)*cosd(alpha4) sin(thetha4)*sind(alpha4);
      sin(thetha4) cos(thetha4)*cosd(alpha4) -cos(thetha4)*sind(alpha4);
      0 sind(alpha4) cosd(alpha4)];
R5 = [cos(thetha5) -sin(thetha5)*cosd(alpha5) sin(thetha5)*sind(alpha5);
      sin(thetha5) cos(thetha5)*cosd(alpha5) -cos(thetha5)*sind(alpha5);
      0 sind(alpha5) cosd(alpha5)];
R6 = [cos(thetha6) -sin(thetha6)*cosd(alpha6) sin(thetha6)*sind(alpha6);
      sin(thetha6) cos(thetha6)*cosd(alpha6) -cos(thetha6)*sind(alpha6);
      0 sind(alpha6) cosd(alpha6)];

R36 = R4*R5*R6