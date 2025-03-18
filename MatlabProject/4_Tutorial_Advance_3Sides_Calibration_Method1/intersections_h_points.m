function [Cent1] = intersections_h_points(C)

x_1 = C(2,:);
z_1 = C(1,:);
plot(x_1,z_1,'mo');
hold on
fitobject=fit(x_1',z_1','poly4','Normalize','on','Robust','Bisquare');
plot(fitobject);
v = 1;
x_1 = sort(x_1); 
for i = x_1(1):x_1(length(x_1))
	x(v) = i;
    y(v) = fitobject(x(v));
    v = v+1;
end
plot(x,y,'bo');
hold off
Cent1=[y;x];
end