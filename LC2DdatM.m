function G = LC2DdatM(m,kappa,f,wLC)

% Generates the data matrix from the function evaluations and the weights
% Copyright (C) P. Dencker and W. Erb 01.10.2016
%-------------------------------------------------------------------------
% INPUT.    
% m = [m1,m2]  : parameters of Lissajous curve
% kappa        : parameters of Lissajous curve
% f            : function values at LC points
% wLC          : weights at LC points

% Output. 
% C            : (m1+1)x(m2+1) data matrix

% Generation of Data Matrix
[M2,M1] = meshgrid(0:m(2),0:m(1));

findM = find(mod(M1+M2+kappa(1)+kappa(2)+1,2));

G = zeros((m(1)+1)*(m(2)+1),1);
G(findM) = f.*wLC;
G = reshape(G,size(M1));

return