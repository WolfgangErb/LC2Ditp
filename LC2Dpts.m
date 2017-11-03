function [xLC, yLC, wLC] = LC2Dpts(m,kappa,range)

% Computes LC points with parameter m1, m2 for a given range
% Copyright (C) P. Dencker and W. Erb 01.10.2016
%-------------------------------------------------------------------------
% INPUT.    
%
% m            : parameters of the Lissajous curve
% kappa        : parameters of Lissajous curve
% range        : range of the x- and y-coordinates
%
% OUTPUT.  
%
% xLC,yLC      : x and y-coordinates of the nodes of the Lissajous curve
% wLC          : weight function for the nodes

% Determination of points
zx = cos(linspace(0,1,m(1)+1)*pi);
zy = cos(linspace(0,1,m(2)+1)*pi);

[LC2,LC1] = meshgrid(zy,zx);
  
% Determination of weight function
W = ones(m(1)+1,m(2)+1)/m(1)/m(2)*2;
W(1,:) = W(1,:)/2;
W(m(1)+1,:) = W(m(1)+1,:)/2;
W(:,1) = W(:,1)/2;
W(:,m(2)+1) = W(:,m(2)+1)/2;
 
% Selection of used points
[M2,M1] = meshgrid(0:m(2),0:m(1));
findM = find(mod(M1+M2+kappa(1)+kappa(2)+1,2));

xLC = LC1(findM)';
yLC = LC2(findM)';
wLC = W(findM)';

% normalize range
[xLC, yLC] = norm_range(xLC,yLC,[-1,1,-1,1],range);

return


