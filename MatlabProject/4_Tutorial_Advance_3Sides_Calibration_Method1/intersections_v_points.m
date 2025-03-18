function [Cent1] = intersections_v_points(C)

x_1 = C(2,:);
z_1 = C(1,:);
plot(z_1,x_1,'mo');
hold on
fitobject=fit(z_1',x_1','poly4','Normalize','on','Robust','Bisquare');
plot(fitobject);
v = 1;
z_1 = sort(z_1); 
for i = z_1(1):z_1(length(z_1))
	x(v) = i;
    y(v) = fitobject(x(v));
    v = v+1;
end
plot(x,y,'bo');
hold off
Cent1=[x;y];
end