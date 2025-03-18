function [Cent1] = intersections_v(image)
[height,width] = size(image);
a =1;
for j = 100:height     % working image region
    for i= 100:width
        if image(j,i)>0
            m=[j;i];       % image pixels
            z_1(a) = j;
            x_1(a) = i;
            a=a+1;
        end
    end
end
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