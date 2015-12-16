function [ distance ] = Distance( p1, p2 )
%DISTANCE Summary of this function goes here
%   Detailed explanation goes here

    [~, sz] = size(p1);
    distance = 0;
    for i=1:sz
       x1 = p1(1,i);
       x2 = p2(1,i);
       
       distance = distance + ( x2 - x1 )^2;
    end
    
    distance = sqrt(distance);
end

