function [Cent,Cent1,idx]=border_blobs(BW)

% find blobs
% Apply bwlabel to the image
[labelledImage, numLabels] = bwlabel(BW); 

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

[height,width] = size(aaa{1});
xx_1 = [];
zz_1 = [];
xx_ = [];
zz_ = [];
a=1;
for k = 1:idx
    for i = 1:width     % working image region
        for j= 1:height
            if aaa{k}(i,j)>0
                m=[i;j];       % image pixels
                xx_1{k}(a) = i;
                zz_1{k}(a) = j;
                a=a+1;
            end
        end
    end
    a=1;
end

%
C = [xx_1{1};zz_1{1}];
C1 = [xx_1{2};zz_1{2}];

Cent = C;
Cent1 = C1;

Cent = intersections_v_points(Cent);
Cent1 = intersections_v_points(Cent1);

figure;
imshow(~BW);
hold on
plot(Cent(2,:),Cent(1,:),'b*');
plot(Cent1(2,:),Cent1(1,:),'r*');
end