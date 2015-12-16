function [ Uk, manifold ] = ComputeEigenspace( xHat, U, k )
%ComputeEigenspace Summary of this function goes here
%   Part 1 of the Program



    
    
    %Get the k-space manifold from U
    Uk = U(:,1:k);
    manifold = xHat' * Uk;
    
    %make a plot or whatever
%     figure;
%     plot3(manifold(:,1),manifold(:,2),manifold(:,3),'m-*');
%     xlabel('X');
%     ylabel('Y');
%     zlabel('Z');
%     title(['3D MANIFOLD: ' object]);
%     grid on;
    
 %   eigen = struct( [ ] );
    %Get optimal images
%     for i=1:12
%        eigen(i).L = reshape(X(:,i), [128,128] );
%        eigen(i).G = reshape(U(:,i), [128,128] );
%        
%        figure,imshowpair(eigen(i).L,eigen(i).G, 'montage');
%     end

end

