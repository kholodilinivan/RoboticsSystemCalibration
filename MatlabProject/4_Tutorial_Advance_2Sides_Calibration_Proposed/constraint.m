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

function [c, ceq] = constraint(x)
global count;
global tan_v;
global tan_v1;
global tan_h;
global tan_h1;

if (count == 1)
    c = []; 
    ceq = tan_h - tan_h1;
elseif (count == 2)
    c = [];
    ceq = tan_v - tan_v1;
else
    c = [];
    ceq = [];
end
end