function C = LC2Dcfsfft(m,kappa,G,average)

% Computes the coefficient matrix of the interpolating polynomial
% Copyright (C) P. Dencker and W. Erb 01.10.2016
%----------------------------------------------------------------------
% INPUT. 
% m = [m1,m2]  : parameters of Lissajous curve
% kappa        : parameters of Lissajous curve
% G            : (m1+1)x(m2+1) data matrix
% average      : 1: average coefficients at border

% Output. 
% C            : (m1+1)x(m2+1) coefficient matrix

% Fast cosine transform of each column of G
Gh = real(fft(G,2*m(1)));   
Gh = Gh(1:m(1)+1,:);           

% Fast cosine transform of each row of Gh
Ghh = real(fft(Gh',2*m(2)))';       
Ghh = Ghh(:,1:m(2)+1);

% Chebyshev normalization factors
[M2,M1] = meshgrid(0:m(2),0:m(1));
Alpha = double((2-(M1<1)).*(2-(M2<1)));

% Mask for coefficients
Mask = LC2Dmask(m,kappa,average);  

% Final coefficient matrix
C = Ghh.*Alpha.*Mask;