function [x,y] = mapping(image,camX,camY,camZ,lasX,lasY,las_dist,ocam_model)
[height,width] = size(image);
Z=las_dist;
a = 1;
x=[];
y=[];
t = [0;0;Z];
r = compose_rotation(lasX, lasY, 0);
r_ = compose_rotation(-camX, -camY, camZ);
r = r_*[r(:,1),r(:,2),t];
for i=1:height      % working image region
    for j=1:width
        if image(i,j)>0
            m=[i;j];       % image pixels
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
end
end