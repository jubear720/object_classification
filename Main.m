function [  img1, img2, obj  ] = Main( GL, Method,o, file, goal )


if nargin < 5
   goal = 0.80; 
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

if strcmp(GL, 'GLOBAL')
    for i=1:20
        object = [Otable{i} num2str(b)];

        data = load(['Imagedata/' object '.mat']);

        G = [G data.X];
        %get local eigenspace
    end
    
     GHat = GetXHat(G);

    %PERFORM THE GREATEST OPERATION IN ALL OF MATHEMATICS
    [Ug,S,V] = svd(GHat, 'econ');
    
XHat = GHat;

end
   

    object = Otable{o};
    
    obj = [object num2str(b)];
    data = load(['Imagedata/' obj '.mat']);

       
    L = data.X; 
    LHat = GetXHat(L);
    if strcmp( GL, 'LOCAL')
       XHat = LHat; 
    end

if strcmp(Method, 'SVD')

    [sz,~] = size(LHat);
    %PERFORM THE GREATEST OPERATION IN ALL OF MATHEMATICS
    [Ul,S,V] = svd(LHat, 'econ');


else    
    loc = 128;
    glob = 128 * 20;

    %FFT
    if strcmp(GL, 'LOCAL')
        x = loc;
    else
        x = glob;
    end
    %%%FFT Part
    fftArray = zeros( 16384, x );

    for i=1:16384
        tempFFT = fft( XHat(i,:) );
        fftArray(i,:) = tempFFT;
    end

    magnitude = sqrt ( conj( fftArray ) .* fftArray );
    fft1D = sum( magnitude, 1 );

    normFFT = fft1D / sum(fft1D);

    total = 0.0;
    k = 0;
    while total < goal
       total = total + 2*normFFT( k+1 );
       k = k + 1;
    end
    [Ufft, S, V] = svd(magnitude(:,1:k), 0);
    
    manifold = XHat' * Ufft;

end

if strcmp(Method, 'FFT')
    U = Ufft;
elseif strcmp(GL, 'LOCAL')
    U = Ul;
elseif strcmp(GL, 'GLOBAL')
    U = Ug;
end


if strcmp(GL, 'LOCAL')
    if strcmp(Method, 'SVD')
        [kList, eList] = ComputeER( LHat, U, goal );
        kLocal = kList(end);
        [ Ukl, MLocal ] = ComputeEigenspace( LHat, U, kLocal );
        manifold = MLocal;
        k = kLocal;
        Uk = Ukl;
    else
        manifold = manifold;
        Uk = Ufft;

    end
    [ img1, img2, obj ] = IdentifyImageLocal( object, file, manifold, k, Uk );

end 
if strcmp(GL, 'GLOBAL')
    
    if strcmp(Method, 'SVD')
        [kList, eList] = ComputeER( GHat, U, goal );
        kGlobal = kList(end);
        [ Ukg, MGlobal ] = ComputeEigenspace( GHat, U, kGlobal );
        manifold = MGlobal;
        k = kGlobal;
        Uk = Ukg;
    else
        manifold = manifold;
        Uk = Ufft;
    end


    [ img1, img2, obj ] = IdentifyImage( object, file, manifold, k, Uk );

end 

    %p80 = [ p80 ComputeSubspace( X, U, .80 ) ];
    %p90 = [ p90 ComputeSubspace( X, U, .90 ) ];
    %p95 = [ p95 ComputeSubspace( X, U, .95 ) ];








end