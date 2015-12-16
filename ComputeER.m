function [ kList, eList ] = ComputeER( X, U, mu )
%COMPUTEER compute energy recovered
%   use the frobenius norm in any instance of normalization

    kList=[];
    eList=[];
    
    k = 1;
    e = 0;
    
    while e < mu  
        %Energy recovery (remember to use frobenius norm)
        numerator   = 0;
        for i=1:k
           numerator = numerator + norm( ( U(:,i).' * X ), 'fro' )^2; 
        end
        denominator = norm( X, 'fro' )^2;
        
        e = numerator / denominator;
        
        kList = [kList k];
        eList = [eList e];
        
        %increment k
        k = k + 1; 
    end
end

