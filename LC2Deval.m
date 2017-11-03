function Sf = LC2Deval(C, m, x, y, range)

% Computes the interpolation polynomial at points (x,y) 
% Copyright (C) P. Dencker and W. Erb 01.10.2016
%------------------------------------------------------------------
% INPUT.    
% m = [m1,m2]  : parameters of the Lissajous curve
% C            : coefficient matrix of the interpolation polynomial
% (x,y)        : evaluation point
% range        : range of the rectangle
%
% OUTPUT.  
% Sf           : evaluated polynomial at point (x,y)


% normalize range
[ x,y ] = norm_range(x,y,range,[-1 1 -1 1]);

% Computation of basis polynomials evaluated at (x,y);
Tx = T(m(1), x);
Ty = T(m(2), y);

% Evaluation of interpolation polynomial via summation
Sf = sum((Tx'*C).*Ty',2)';
