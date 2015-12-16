function [ k, energy ] = ComputeSubspace( X,U, mu )
%COMPUTESUBSPACE Calculate the appropriate subspace dimension
%   Part 2

    [ kList, eList ] = ComputeER( X, U, mu );
    
    k = kList(end);
    energy = eList(end);
    %figure, plot( kList, eList, 'm-o');

end

