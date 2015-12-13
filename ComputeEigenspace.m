function [ eigen ] = ComputeEigenspace( object )
%ComputeEigenspace Summary of this function goes here
%   Part 1 of the Program

    data = load(['Imagedata/' object '.mat']);

    %get local eigenspace
    X = data.X; 

    %create empty vector of size X
    fBar = zeros(size(X,1), 1);

    n = size(X,2);

    % fBar = 1/n SUM( fp ) for i=1:n
    for i=1:n
        fBar = fBar + X(:,i);

    end
    fBar = fBar ./ n;
    
    %xHat = [f1 - fBar, f2 - fBar, ...., fn - fBar]
    xHat = zeros(size(X));
    for i=1:n
       xHat(:,i) = X(:,i) - fBar; 
    end
    
    %PERFORM THE GREATEST OPERATION IN ALL OF MATHEMATICS
    [U,S,V] = svd(xHat, 0);
    
    %Get the 3-space manifold from U
    u3 = U(:,1:3);
    manifold = xHat.' * u3;
    
    %make a plot or whatever
    figure;
    plot3(manifold(:,1),manifold(:,2),manifold(:,3),'m-*');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    titlebar = strcat('3D MANIFOLD:    ', object);
    title(titlebar);
    grid on;
    
    eigen = struct( [ ] );
    for i=1:9
       eigen(i).local  = reshape(X(:,i) , [128,128] );
       eigen(i).global = reshape(U(:,i) , [128,128] );
    end

    
end

