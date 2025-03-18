function [Cent1] = intersections_h(image)
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