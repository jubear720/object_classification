function [ img, nearestImage, object ] = IdentifyImage( object, filenum, M, k, Uk )
%IDENTIFYIMAGE Summary of this function goes here
%   Detailed explanation goes here

Otable = {'Boat','Cabinet','Car','Chair','Cup','Flashlight','Handle',...
    'HoseReel','ibook01','imac04','imac98','Keyboard','LED','Light1',...
    'Light2','Mug','Scooter','SprayBottle','Stapler','Trash'};

        b = 32;
        file = [object num2str(b)];
        img = im2double(imread(['TestImages/' file '/UnProcessed/img_' filenum '.png']));
        
        [sz,~] = size(M);
        sz
        %change to vector
        f = reshape(img, [], 1);

        p = [];
        p(:,1:k) = f' * Uk(:,1:k);
        
        minq = 9999999999;
        image_index = 1;
        
        for i=1:sz
            dist = Distance(p, M(i,:));
            if dist < minq
               %You are at image i - 1!
               minq = dist;
               image_index = i - 1;
            end
        end
        
        qqqq = image_index
        imageSet = floor((image_index)/ 128) + 1
        image_index = mod(image_index, 128)
                

        file = [object num2str(b*2)];
        image_name = ['TrainingImages/' file '/UnProcessed/img_' int2str(image_index) '.png'];
       
        figure;
        hold on;
        plot3(M(:,1),M(:,2),M(:,3),'m-*');
        p2image = [p(1,1)           p(1,2)           p(1,3); 
                   M(image_index+1,1) M(image_index+1,2) M(image_index+1,3)];
        plot3(p2image(:,1),p2image(:,2),p2image(:,3),'b-o');

        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        title(['3D MANIFOLD: ' object]);
        grid on;
        hold off;
        nearestImage = imread(image_name);
        
        %figure,imshowpair(img, nearestImage, 'montage');
        %title(['Hello, I am a ' object]);
        
end

