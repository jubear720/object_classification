function [ output_args ] = EigenImage( X, U, total )
%EIGENIMAGE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
   total = 20; 
end
   eigen = struct( [ ] );
    %Get optimal images
    for i=1:total
       eigen(i).L = reshape(X(:,i), [128,128] );
       eigen(i).G = reshape(U(:,i), [128,128] );
       
       figure,imshowpair(eigen(i).L,eigen(i).G, 'montage');
    end
end

