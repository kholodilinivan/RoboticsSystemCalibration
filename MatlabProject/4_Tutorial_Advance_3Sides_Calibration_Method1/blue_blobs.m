function [XSort,YSort,idx]=blue_blobs(I_,I1_)

% find blobs
% Apply bwlabel to the image
[labelledImage, numLabels] = bwlabel(I_); 

aaa = {};
%// For each label...
for idx = 1 : numLabels
    %// Create a mask for this particular blob
    mask = labelledImage == idx;
    aaa{idx} = mask;
    %// Apply regionprops on this mask only
    stats = regionprops(mask, 'all');

    %// Use stats and mask in however way you see fit
    %// ...
    %// ...
end
% sort blobs
figure
imshow(I1_);
hold on
xx_1 = [];
zz_1 = [];
a=1;
for k = 1:idx
    [width,height] = size(aaa{k});
    for i = 1:width     % working image region
        for j= 1:height
            if aaa{k}(i,j)>0
                m=[i;j];       % image pixels
                xx_1(a) = i;
                zz_1(a) = j;
                a=a+1;
            end
        end
    end
    xx_(k) = mean(xx_1);
    zz_(k) = mean(zz_1);
    xx_1 = [];
    zz_1 = [];
    a=1;
end
plot(zz_,xx_,'m*');
Points(:,1) = zz_; % rewrite to array
Points(:,2) = xx_;

Points = sortrows(Points); % sort from in ascending order (X - coordinate)
for i=1:2:length(zz_)
    if(Points(i,2)>Points(i+1,2)) % if among two points, first point has... 
...bigger Y-coordinate - write points to the sort array in the same order
        PointSort(i,1) = Points(i,1);
        PointSort(i,2) = Points(i,2);
        PointSort(i+1,1) = Points(i+1,1);
        PointSort(i+1,2) = Points(i+1,2);
    else
        PointSort(i,1) = Points(i+1,1); % if among two points, second ... 
... point has bigger Y-coordinate - write points to the sort array... 
... in the opposite order
        PointSort(i,2) = Points(i+1,2);
        PointSort(i+1,1) = Points(i,1);
        PointSort(i+1,2) = Points(i,2);
    end
end
clear Points;
XSort = PointSort(:,1);
YSort = PointSort(:,2);
end