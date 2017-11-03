function f = testfun2D(x,y,k)

%   2D test functions

%   INPUT    
%   x,y         x,y coordinates to evaluate the functions
%   k           index for one of the test functions
%
%   OUTPUT     
%   f           resulting function values


switch k
        
    case 1  
        
    f = exp(sin(10*x)) + sin(6*exp(y)) + sin(7*sin(x))+...
        sin(sin(8*y))-sin(x + y)+ 1/4*(x.^2 + y.^2);
    
    case 2
     
    f = exp(-(5-10*x).^2/2)+0.7*exp(-(5-10*y).^2/2)+...
            0.3*exp(-(5-10*x).^2/2).*exp(-(5-10*y).^2/2);
        
    case 3
    
    f = exp(-0.05*sqrt((80*x-40).^2+(90*y-45).^2)).*...
            cos(0.3*sqrt((80*x-40).^2+(90*y-45).^2));
        
    case 4   % Chebyshev basis polynomial
    
    K = [1,2];
    f = cos(K(1)*acos(x)).*cos(K(2)*acos(y));
    
    case 5
        
    f = franke(1-x,1-y);
    
    case 6   % Product of two Chebyshev basis polynomials
    
    K1 = [1,3]; K2 = [1,3];
    f = cos(K1(1)*acos(x)).*cos(K1(2)*acos(y)).*cos(K2(1)*acos(x)).*cos(K2(2)*acos(y));
    
    otherwise
        
    error('There is no function associated to this number');

end