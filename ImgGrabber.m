function [ img ] = ImgGrabber( filename )
%IMGGRABBER Summary of this function goes here
%   Detailed explanation goes here

img = im2double(imread(filename));
end

