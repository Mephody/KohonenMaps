% This program takes an image and corrupts 1 block in it.

picture_to_corrupt = imread('gornyj-pejzazh.jpg');

percent = 50;

x_scale = 3;
y_scale = 3;


horizontal_barrier = size(picture_to_corrupt, 1)/neuron_size;
vertical_barrier = size(picture_to_corrupt, 2)/neuron_size;
    
X_rand1 = randi([1 horizontal_barrier - x_scale]) * neuron_size + neuron_size/2;
Y_rand1 = randi([1 vertical_barrier - y_scale]) * neuron_size + neuron_size/2;

X_rand2 = X_rand1 + neuron_size * x_scale;
Y_rand2 = Y_rand1 + neuron_size * y_scale;

for i=X_rand1:X_rand2
    for j=Y_rand1:Y_rand2
    picture_to_corrupt(i, j, :) = zeros(1, 1, 3);
    end
end

corrupted_image = picture_to_corrupt;
image(picture_to_corrupt);
save('corrupted_image', 'corrupted_image');