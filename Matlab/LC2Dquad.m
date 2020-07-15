function Qf = LC2Dquad(C, m, range)

% Computes the integral of a function f over a rectangle using the 
% Clenshaw-Curtis quadrature formula 
% As an input the Chebyshev coefficients of the function f are required
% Copyright (C) W. Erb 01.07.2020
%------------------------------------------------------------------
% INPUT.    
% m = [m1,m2]  : parameters of the Lissajous curve
% C            : coefficient matrix of the interpolation polynomial
% range        : range of the rectangle
%
% OUTPUT.  
% Qf           : integral of function over rectangle

m1 = floor(m(1)/2);
m2 = floor(m(2)/2);
area = (range(2)-range(1))*(range(4)-range(3));

% Generation of quadrature weights
wx = zeros(m(1)+1,1);
wy = zeros(m(2)+1,1);
wx(1:2:2*m1+1) = (2./(1-(0:2:2*m1).^2))';
wy(1:2:2*m2+1) = (2./(1-(0:2:2*m2).^2))';

% Evaluation of CC quadrature formula via summation
Qf = area*sum((wx'*C).*wy',2)/4;
