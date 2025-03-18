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

function obj = objective_roll_las(roll)

global ocam_model;
global Cent;
global cam_pitch_opt;
global cam_roll_opt;
global cam_yaw_opt;

clf;
h2 = [];
x = [];
y = [];

[x,y] = mapping_points(Cent,cam_roll_opt,cam_pitch_opt,cam_yaw_opt,...
    roll,0,1,ocam_model);
ax1 = subplot(2,1,1);
scatter(ax1,x,y,5,'filled'); % Laser intersections
hold on;
grid on;
h2 = lsline(ax1);

% horizontal
up = atand(diff(h2(1).YData)/diff(h2(1).XData));
    
obj = abs(up);
end