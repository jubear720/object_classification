function [ xHat ] = GetXHat( x )
%GETXHAT Summary of this function goes here
%   Detailed explanation goes here



    %create empty vector of size X
    fBar = zeros(size(x,1), 1);

    n = size(x,2);

    % fBar = 1/n SUM( fp ) for i=1:n
    for i=1:n
        fBar = fBar + x(:,i);
    end
    fBar = fBar / n;
    
    %xHat = [f1 - fBar, f2 - fBar, ...., fn - fBar]
    xHat = zeros(size(x));
    for i=1:n
       xHat(:,i) = x(:,i) - fBar; 
    end
end

