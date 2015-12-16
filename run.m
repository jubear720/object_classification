close all

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
for i=1:20
    object = [Otable{i} num2str(b)];

    data = load(['Imagedata/' object '.mat']);

    G = [G data.X];
    %get local eigenspace
end

    GHat = GetXHat(G);

    %PERFORM THE GREATEST OPERATION IN ALL OF MATHEMATICS
    [Ug,S,V] = svd(GHat, 'econ');
    
    [kList, eList] = ComputeER( GHat, Ug, 0.80 );
    kGlobal = kList(end);
    [ Ukg, MGlobal ] = ComputeEigenspace( GHat, Ug, kGlobal );

    
for i=1:1
    object = [Otable{i}]
    
    obj = [object num2str(b)];
    data = load(['Imagedata/' obj '.mat']);

        
    L = data.X; 
    LHat = GetXHat(L);
    
    [sz,~] = size(LHat);
    %PERFORM THE GREATEST OPERATION IN ALL OF MATHEMATICS
    [Ul,S,V] = svd(LHat, 'econ');

    [kList, eList] = ComputeER( LHat, Ul, 0.80 );
    k = kList(end);
    p80 = [ p80 k ];

    figure;
    plot(kList,eList)
     [kList, eList] = ComputeER( LHat, Ul, 0.90 );
    k = kList(end);
    p90 = [ p90 k ];
    
        figure;

    plot(kList,eList)

     [kList, eList] = ComputeER( LHat, Ul, 0.95 );
    k = kList(end);
    p95 = [ p95 k ];
    
        figure;

    plot(kList,eList)

end

x = 1:20;


figure;
bar(p80,0.4);
xlim([0 21]);
ylim([0 50]);
title('k values to reach 80% energy recovery');

figure;
bar(p90,0.4);
xlim([0 21]);
ylim([0 50]);
title('k values to reach 90% energy recovery');

figure;
bar(p95,0.4);
xlim([0 21]);
ylim([0 50]);
title('k values to reach 95% energy recovery');
