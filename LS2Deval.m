function Sf = LS2Deval(C, n, x, y)

% (C) Wolfgang Erb 01.05.2016
% Computes the interpolation polynomial at the point (x,y) 
%------------------------------------------------------------------
% INPUT    
% n = [n1,n2]  : parameters of the Lissajous curve
% C            : coefficient matrix of the interpolation polynomial
% (x,y)        : evaluation point
%
% OUTPUT  
% Sf           : evaluated polynomial at point (x,y)


% normalize range
[ x,y ] = norm_range( x,y,[-1 1 -1 1]);

% Computation of Chebyshev polynomials evaluated at (x,y)
Tx = cos([0:n(1)]'*acos(x));
Ty = cos([0:n(2)]'*acos(y));

Tx(2:n(1)+1,:) = sqrt(2)*Tx(2:n(1)+1,:);
Ty(2:n(2)+1,:) = sqrt(2)*Ty(2:n(2)+1,:);

% Evaluation of interpolation polynomial via summation
Sf = sum((Tx'*C).*Ty',2)';
