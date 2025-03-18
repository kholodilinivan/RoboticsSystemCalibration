%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%   Author: Ivan Kholodilin
%   email: kholodilin@bit.edu.cn
%   website: www.ilabit.org
%
%   Copyright (C) 2020 Ivan Kholodilin
%   
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%   
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%   
%   You should have received a copy of the GNU General Public License
%   along with this program; if not, write to the Free Software
%   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
%   USA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,y] = mapping_points(Cent,camX,camY,camZ,lasX,lasY,las_dist,ocam_model)
Z=las_dist;
a = 1;
x=[];
y=[];
t = [0;0;Z];
r = compose_rotation(lasX, lasY, 0);
r_ = compose_rotation(-camX, -camY, camZ);
r = r_*[r(:,1),r(:,2),t]; 
for i=1:length(Cent)
    m=[Cent(1,i);Cent(2,i)]; 
    M = cam2world(m,ocam_model); % transform from image plane to the camera plane         
    a1 = M(1)*r(2,1)-M(2)*r(1,1);
    b1 = M(1)*r(2,2)-M(2)*r(1,2);
    c1 = M(1)*r(2,3)-M(2)*r(1,3);
    a2 = M(3)*r(1,1)-M(1)*r(3,1);
    b2 = M(3)*r(1,2)-M(1)*r(3,2);
    c2 = M(3)*r(1,3)-M(1)*r(3,3);

    Y = (a2*c1-a1*c2)/(a1*b2-a2*b1);
    X = (-c1-b1*Y)/a1;   
 
    y(a)=X;
    x(a)=-Y; 
    a=a+1;
end
end