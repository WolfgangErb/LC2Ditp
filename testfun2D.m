function f = testfun2D(x,y,k)

%   INPUT    
%   x,y         x,y coordinates to evaluate the functions
%   k           index for one of the test functions
%
%   OUTPUT     
%   f           resulting function values


switch k
        
    case 1  
        
    f = exp(sin(10*(1-x))) + sin(6*exp(1-y)) + sin(7*sin(1-x))+...
        sin(sin(8*(1-y)))-sin(2-x - y)+ 1/4*((1-x).^2 + (1-y).^2);
    
    case 2
     
    f = exp(-(5-10*x).^2/2)+0.7*exp(-(5-10*y).^2/2)+...
            0.3*exp(-(5-10*x).^2/2).*exp(-(5-10*y).^2/2);
        
    case 3
    
    f = exp(-0.05*sqrt((80*x-40).^2+(90*y-45).^2)).*...
            cos(0.3*sqrt((80*x-40).^2+(90*y-45).^2));
        
    case 4   % Chebyshev basis polynomial
    
    K = [3,2];
    f = cos(K(1)*acos(x)).*cos(K(2)*acos(y));
    
    case 5
        
    f = franke(1-x,1-y);
    
    otherwise
        
    error('There is no function associated to this number');

end