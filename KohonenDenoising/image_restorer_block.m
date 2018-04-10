% This program goes in pair wirth image_corruptor_block. It takes corrupted image
% with block corruption and tries to restore him. I dont think it's
% working, but as i think there is problem with little map or bad map
% drawing, so it's can be reparied with bigger and more detailed map (as i
% think).

load('map_file');
load('corrupted_image');

part_of_picture = zeros(neuron_size, neuron_size, 3);
restored_image = zeros(size(corrupted_image));
neurons_size_const = neuron_size*neuron_size*3;


for i=1:2*size(corrupted_image, 1)/neuron_size - 1
    for m=1:2*size(corrupted_image, 2)/neuron_size - 1
    
        part_of_picture = double(corrupted_image((i-1)*neuron_size/2+1:(i+1)*neuron_size/2, (m-1)*neuron_size/2+1:(m+1)*neuron_size/2, :));
        
%         image(uint8(part_of_picture));
        
        logic = (part_of_picture~=zeros(neuron_size, neuron_size, 3));
        temp = map((1-1)*neuron_size+1:1*neuron_size, (1-1)*neuron_size+1:1*neuron_size, :);
        E_min = sum(sum(sum((part_of_picture(logic)-temp(logic)).^2)))/neurons_size_const;
        
        for j=1:map_size
            for k=1:map_size

                temp = map((j-1)*neuron_size+1:j*neuron_size, (k-1)*neuron_size+1:k*neuron_size, :);
                
                E = sum(sum(sum((part_of_picture(logic)-temp(logic)).^2)))/neurons_size_const;
                if(E<E_min)
                    E_min=E;
                    jk_min=[j,k];
                end
            end
        end
        
        temp = map((jk_min(1)-1)*neuron_size+1:jk_min(1)*neuron_size, (jk_min(2)-1)*neuron_size+1:(jk_min(2))*neuron_size, :);
        part_of_picture(~logic) = temp(~logic);
        restored_image((i-1)*neuron_size/2+1:(i+1)*neuron_size/2, (m-1)*neuron_size/2+1:(m+1)*neuron_size/2, :) = part_of_picture;
        
        
        
    end
end
    
image(uint8(restored_image));
imwrite(uint8(restored_image), 'restored_image.jpg');

