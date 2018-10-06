function R = LC2Dmask(m,kappa,average)

% Computes the mask for the coefficients of the interpolation polynomial
% Copyright (C) P. Dencker and W. Erb 01.10.2016
%----------------------------------------------------------------------
% INPUT.    
% m = [m1,m2]  : frequency parameters of LC-points
% kappa        : phase shift parameters of LC-points
% average      : 1 = average coefficients on border of triangle

% Output. 
% R            : (m1+1)x(m2+1) mask for interpolation on LC-points 

[M2,M1] = meshgrid(0:m(2),0:m(1));

R = double(M1*m(2)+M2*m(1)<m(1)*m(2)); 

if (average == 1)
    Req = double(M1*m(2)+M2*m(1)==m(1)*m(2))/2;
    Req(1,m(2)+1) = 1/4; Req(1+m(1),1) = 1/4;
    
    if (mod(kappa(1)+kappa(2),2) == 1) && (mod(m(1),2) == 0) && (mod(m(2),2) == 0);
        Req(m(1)/2+1,m(2)/2+1) = 0;
    end
else
    Req = double(M1*m(2)+M2*m(1)==m(1)*m(2)).*double(M1/m(1) < M2/m(2));
    Req(1,m(2)+1) = 1/2;
    
    if (mod(kappa(1)+kappa(2),2) == 0) && (mod(m(1),2) == 0) && (mod(m(2),2) == 0);
        Req(m(1)/2+1,m(2)/2+1) = 1/2;
    end
end

R = R + Req;

end