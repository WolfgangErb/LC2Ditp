% Test example for bivariate polynomial interpolation 
% on general Lissajous-Chebyshev node points LC 
% (C) P. Dencker and W. Erb 01.10.2016

clear all
close all

% Parameters 
m       = [28,29];        % Frequency parameter of LC-points
kappa   = [0,0];          % Phase shift parameter of LC-points

range   = [0 1 0 1];      % Rectangular range for interpolation
nofun   = 3;              % Number of test function [1-6]

average = 1;              % 1: Use averaged coefficients at border

Nd      = 100;            % Discretization for plot

% Coordinates and weights of LC points
[xLC, yLC, wLC] = LC2Dpts(m,kappa,range);
NoLC = length(xLC);
        
% Extraction of function values
fLC = testfun2D(xLC,yLC,nofun);
      
% Computation of data Matrix
G = LC2DdatM(m,kappa,fLC,wLC);

% Computation of coefficient matrix
C = LC2Dcfsfft(m,kappa,G,average);
  
% Evaluation of the interpolation polynomial
[x, y] = meshgrid(linspace(range(1),range(2),Nd),linspace(range(3),range(4),Nd));   

xlin   = reshape(x,1,Nd^2);               % Reshaping target points in 1D-vector         
ylin   = reshape(y,1,Nd^2);
    
Sflin = LC2Deval(C,m,xlin,ylin,range);    % Values of the interpolation polynomial
SfLC  = LC2Deval(C,m,xLC,yLC,range);      % Values of the interpolation polynomial
Sf    = reshape(Sflin,Nd,Nd);             % Reshaping evaluated points in 2D-matrix

% Evaluation of integral
Qf    = LC2Dquad(C, m, range);
        
% Plot of the interpolation polynomial

figure(1),clf,
colormap(copper);
surfl(x, y, Sf);
shading interp
hold on;
plot3(xLC,yLC,fLC,'o','LineWidth',1,'markersize',5,'MarkerFaceColor',[0.8,0.8,0.8],'MarkerEdgeColor','k');
hold off

        
% Calculation of the maximal error between function and polynomial interpolation
maxerror   = norm(Sflin-testfun2D(xlin,ylin,nofun),inf);
maxerrorLC = norm(SfLC-fLC,inf);

if (maxerrorLC > 1e-12)
    fprintf('Error: Interpolation not successful!\n');
else
    fprintf('Interpolation successful!');
    if (maxerror < 1e-12)
        fprintf(' The test function was reproduced exactly.\n');
    else
        fprintf(' \n');
    end
end

fprintf('Number of interpolation points      : %23d \n',NoLC);
fprintf('Maximal error for approximation     : %23.18f \n',maxerror);
fprintf('Maximal error at LC points          : %23.18f \n\n',maxerrorLC);
fprintf('Integral of function over range     : %23.18f \n\n',Qf);
        


