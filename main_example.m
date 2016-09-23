% Test example for bivariate polynomial interpolation 
% on the node points LS of Lissajous curves 
% (C) Wolfgang Erb 01.05.2016

% Parameters 
n       = [7,8];        % Parameter of Lissajous curve
e       = 2;              % e = 1 (degenerate), e = 2 (non-degenerate)

range   = [0 1 0 1];      % Rectangular range for interpolation
nofun   = 1;              % Number of test function [1-5]

Nd      = 100;            % Discretization for plot

% Normalize n in case n1 and n2 are not relatively prime

n = n/gcd(n(1),n(2));

% Coordinates and weights of LS points
[xLS, yLS, wLS] = LS2Dpts(n,e,range);
        
% Extraction of function values
f = testfun2D(xLS,yLS,nofun);
      
% Computation of Coefficient Matrix
G = LS2DdatM(n,e,f,wLS);
C = LS2Dcfsfft(e*n,G);
        
% Evaluation of the interpolation polynomial
[x, y] = meshgrid(linspace(range(1),range(2),Nd),linspace(range(3),range(4),Nd));   

% Reshaping target points in 1D-vector
xlin   = reshape(x,1,Nd^2);             
ylin   = reshape(y,1,Nd^2);

       
Sflin = LS2Deval(C,e*n,xlin,ylin);          % Values of the interpolation polynomial
Sf    = reshape(Sflin,Nd,Nd);             % Reshaping evaluated points in 2D-matrix
        
% Plot of the interpolation polynomial

figure(1),clf,
colormap(pink);
surf(x, y, Sf);
hold on;
scatter3(xLS,yLS,f,'MarkerFaceColor',[0 0.9 0.2]);
        
% Calculation of the maximal error between function and polynomial interpolation
maxError = max(abs(Sflin-testfun2D(xlin,ylin,nofun)));

fprintf('Maximal interpolation error: %16.14f \n\n',maxError);
        


