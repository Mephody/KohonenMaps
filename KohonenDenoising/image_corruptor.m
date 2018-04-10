% This program takes an image and corrupts him.

picture_to_corrupt = imread('gornyj-pejzazh.jpg');

percent = 50;%Corrupted pixels percent
X_rand = 0;
Y_rand = 0;

for i=1:size(picture_to_corrupt, 1)*size(picture_to_corrupt, 2)*(percent/100)
    
        X_rand = randi([1 size(picture_to_corrupt, 1)]);
        Y_rand = randi([1 size(picture_to_corrupt, 2)]);
        picture_to_corrupt(X_rand, Y_rand, :) = zeros(1, 1, 3);
    
end
corrupted_image = picture_to_corrupt;
image(picture_to_corrupt);
save('corrupted_image', 'corrupted_image');