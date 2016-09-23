function [xLS, yLS, wLS] = LS2Dpts(n,e,range)

% (C) Wolfgang Erb 01.05.2016
% Computes Lissajous nodes with parameter n1, n2 and e for a given range
%-------------------------------------------------------------------------
% INPUT   
% n=[n1,n2]    : parameters of the Lissajous curve
% e            : e = 1 (degenerate), e = 2 (non-degenerate)
% range        : range of the x- and y-coordinates
%
% OUTPUT  
% xLS,yLS      : x and y-coordinates of the nodes of the Lissajous curve
% wLS          : weight function for the nodes

% Determination of points
zx = cos(linspace(0,1,e*n(1)+1)*pi);
zy = cos(linspace(0,1,e*n(2)+1)*pi);

[LS1,LS2] = meshgrid(zy,zx);
  
% Determination of weight function
W = ones(e*n(1)+1,e*n(2)+1)/n(1)/n(2)*2/e^2;
W(1,:) = W(1,:)/2;
W(e*n(1)+1,:) = W(e*n(1)+1,:)/2;
W(:,1) = W(:,1)/2;
W(:,e*n(2)+1) = W(:,e*n(2)+1)/2;
 
% Selection of used points
[M1,M2] = meshgrid(0:e*n(2),0:e*n(1));
findM = find(mod(M1+M2+e,2));

yLS = LS1(findM);
xLS = LS2(findM);
wLS = W(findM);

% normalize range
[xLS, yLS] = norm_range(xLS,yLS,range);

return


