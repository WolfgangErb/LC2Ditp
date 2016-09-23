function [x,y] = norm_range(x,y,range)

% This function normalizes the range of the vectors x,y from
%          [x_min,x_max]x[y_min,y_max] to
%          [range(1), range(2)]x[range(3),range(4)]

% normalize the range to [0,1]x[0,1]
x = (x - min(x)) / (max(x) - min(x));
y = (y - min(y)) / (max(y) - min(y));

% map [0,1]x[0,1] to [range(1), range(2)]x[range(3),range(4)]
x = (x*(range(2)-range(1))) + range(1);
y = (y*(range(4)-range(3))) + range(3);

end

