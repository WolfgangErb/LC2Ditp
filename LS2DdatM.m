function G = LS2DdatM(n,e,f,wLS)

% (C) Wolfgang Erb 01.05.2016
% Generates the data matrix from the function evaluations and the weights
%-------------------------------------------------------------------------
% INPUT    
% n = [n1,n2]  : parameters of Lissajous curve
% e            : e = 1 (degenerate), e = 2 (non-degenerate)
% f            : function values at LS points
% wLS          : weights at LS points

% Output
% C            : (e n1+1)x(e n2+1) data matrix

% Generation of Data Matrix
[M2,M1] = meshgrid(0:e*n(2),0:e*n(1));
findM = find(mod(M1+M2+e,2));

G = zeros((e*n(1)+1)*(e*n(2)+1),1);
G(findM) = f.*wLS;
G = reshape(G,size(M1));

return