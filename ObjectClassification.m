function ObjectClassification( index, eigenspace, Mu  )
%OBJECTCLASSIFICATION Classify objects from each of the test images
%   Part 3

if nargin < 3
   eigenspace = 'L';
   Mu = 0.8;
end

Otable = {'Boat','Cabinet','Car','Chair','Cup','Flashlight','Handle',...
    'HoseReel','ibook01','imac04','imac98','Keyboard','LED','Light1',...
    'Light2','Mug','Scooter','SprayBottle','Stapler','Trash'};

b = 64;
n = 2*b;
m = 128;

p80 = [];
p90 = [];
p95 = [];

L = [];
G = [];

if strcmp(eigenspace, 'G')
    for i=1:20
        object = [Otable{i} num2str(b)];

        data = load(['Imagedata/' object '.mat']);

        G = [G data.X];
        GHat = GetXHat(G);
        %get local eigenspace
    end

    %PERFORM THE GREATEST OPERATION IN ALL OF MATHEMATICS
    [U,S,V] = svd(GHat, 'econ'); 
end


    
    object = [Otable{index}];
    
    obj = [object num2str(b)];
    data = load(['Imagedata/' obj '.mat']);

        
    L = data.X; 
    LHat = GetXHat(L);
    
   [U,S,V] = svd(LHat, 'econ'); 

    


    if strcmp( eigenspace, 'L')
        X = LHat;
    else
        X = GHat;
    end
    
    [kList, eList] = ComputeER( LHat, U, Mu );
    k = kList(end)
    [ Uk, M ] = ComputeEigenspace( X, U, k );
    IdentifyImage( object, M, k, Uk );

end

