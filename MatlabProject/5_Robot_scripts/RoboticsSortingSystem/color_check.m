function color = color_check(Client)

test = ImageReadTCP_One(Client,'Center');
figure;
imshow(test);
R = test(:,:,1);
G = test(:,:,2);
B = test(:,:,3);
if (mean(mean(R)) > 70 || mean(mean(G)) > 70 || mean(mean(B)) > 70)
    if B > G & B > R
        color = 1; % Blue Color
    elseif G > R & G > B
        color = 2; % Green Color
    end
else
    color = 3; % Black Color
end