% This program goes in pair wirth image_corruptor. It takes corrupted image
% and tries to restore him.

load('map_file');
load('corrupted_image');

part_of_picture = zeros(neuron_size, neuron_size, 3);
restored_image = zeros(size(corrupted_image));
neurons_size_const = neuron_size*neuron_size*3;


for i=1:size(corrupted_image, 1)/neuron_size
    for m=1:size(corrupted_image, 2)/neuron_size
    
        part_of_picture = double(corrupted_image((i-1)*neuron_size+1:i*neuron_size, (m-1)*neuron_size+1:m*neuron_size, :));
        
%         image(uint8(part_of_picture));
        
        logic = (part_of_picture~=zeros(neuron_size, neuron_size, 3));
        temp = map((1-1)*neuron_size+1:1*neuron_size, (1-1)*neuron_size+1:1*neuron_size, :);
        E_min = sum(sum(sum((part_of_picture(logic)-temp(logic)).^2)))/neurons_size_const;
        %BMU search
        for j=1:map_size
            for k=1:map_size
%                 logic = (part_of_picture~=zeros(neuron_size, neuron_size, 3));
                temp = map((j-1)*neuron_size+1:j*neuron_size, (k-1)*neuron_size+1:k*neuron_size, :);
                
                E = sum(sum(sum((part_of_picture(logic)-temp(logic)).^2)))/neurons_size_const;
                if(E<E_min)
                    E_min=E;
                    jk_min=[j,k];
                end
            end
        end
        
        % Corrupted pixels exchange
        temp = map((jk_min(1)-1)*neuron_size+1:jk_min(1)*neuron_size, (jk_min(2)-1)*neuron_size+1:(jk_min(2))*neuron_size, :);
        part_of_picture(~logic) = temp(~logic);
        restored_image((i-1)*neuron_size+1:i*neuron_size, (m-1)*neuron_size+1:m*neuron_size, :) = part_of_picture;
        
        
        
    end
end
    
image(uint8(restored_image));
imwrite(uint8(restored_image), 'restored_image.jpg');

