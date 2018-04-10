% This program represent a functional of Kohonene self organising maps.
% Detailed explanation and representation can be found here https://habrahabr.ru/post/120473/
% or here http://jre.cplire.ru/koi/oct10/3/text.html, or here https://en.wikipedia.org/wiki/Self-organizing_map
% You can find a lot of information about this algorithm in internet by
% searching kohonen maps algorithm.


picture_in = imread('gornyj-pejzazh.jpg');
% picture_in = imread('alotofcolors.jpg');
% imshow(picture_in);

map_size = 80;
neuron_size = 4;
neurons_size_const = neuron_size * neuron_size * 3;

map_barrier = map_size*neuron_size;
map = randi([1, 200], map_barrier, map_barrier, 3);


part_of_picture = zeros(neuron_size, neuron_size, 3);
BMU = zeros(neuron_size, neuron_size, 3);

horizontal_barrier = size(picture_in, 1)/neuron_size;
vertical_barrier = size(picture_in, 2)/neuron_size;
X_rand = 1;
Y_rand = 1;

E = 0;
E_min = 0;
jk_min = [1,1];
% radius = 2;

N_iter = 5000;

% figure;

for i=1:N_iter
%     Part gaining
    
    X_rand = randi(horizontal_barrier);
    Y_rand = randi(vertical_barrier);
    part_of_picture =  double(picture_in((X_rand-1)*neuron_size+1:(X_rand)*neuron_size, (Y_rand-1)*neuron_size+1:(Y_rand)*neuron_size, :));
    
%     BMU search
    jk_min=[1,1];
    
    E_min = sum(sum(sum((part_of_picture-map((1-1)*neuron_size+1:1*neuron_size, (1-1)*neuron_size+1:1*neuron_size, :)).^2)))/neurons_size_const;
    for j=1:map_size
        
        for k=1:map_size
            E = sum(sum(sum((part_of_picture-map((j-1)*neuron_size+1:j*neuron_size, (k-1)*neuron_size+1:k*neuron_size, :)).^2)))/neurons_size_const;
            if(E<E_min)
                E_min=E;
                jk_min=[j,k];
            end
            
        end
        
    end
%     Map replacement
    
%     imshow(uint8(map));
    
    for j=1:map_size
        
        for k=1:map_size

                map((j-1)*neuron_size+1:j*neuron_size, (k-1)*neuron_size+1:k*neuron_size, :) = ...
                    map((j-1)*neuron_size+1:j*neuron_size, (k-1)*neuron_size+1:k*neuron_size, :) + ... 
                    hci(i, j, k, jk_min(1), jk_min(2), neuron_size, neuron_size)* ...
                    (part_of_picture - map((j-1)*neuron_size+1:j*neuron_size, (k-1)*neuron_size+1:k*neuron_size, :));
%                 fprintf("j=%d k=%d hci=%d \n", j,k,hci(i, j, k, jk_min(1), jk_min(2)));

            
        end
    end
    
    E=0;
    if (mod(i, 100)==0) 
        fprintf('N_iter=%d\n', i);
%        imshow(uint8(map));
    end

    
end

imshow(uint8(map));
map_double = map;
save('map_file', 'map_double', 'neuron_size', 'map_size');