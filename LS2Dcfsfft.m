function C = LS2Dcfsfft(n,G)

% (C) Wolfgang Erb 01.05.2016
% Computes the coefficient matrix of the interpolating polynomial
%----------------------------------------------------------------------
% INPUT    
% n = [n1,n2]  : parameters of Lissajous curve
% G            : (n1+1)x(n2+1) data matrix

% Output 
% C            : (n1+1)x(n2+1) coefficient matrix

% Fast cosine transform of each column of G
Gh = real(fft(G,2*n(1)));   
Gh = Gh(1:n(1)+1,:);           

% Fast cosine transform of each row of Gh
Ghh = real(fft(Gh',2*n(2)))';       
Ghh = Ghh(:,1:n(2)+1);

% Chebyshev normalization factors
[M2,M1] = meshgrid(0:n(2),0:n(1));
Alpha = sqrt((2-(M1<1)).*(2-(M2<1)));

% Mask for coefficients
Mask = double(M1*n(2)+M2*n(1)<n(1)*n(2));  
Mask(1,n(2)+1) = 1/2;

% Final coefficient matrix
C = Ghh.*Alpha.*Mask;