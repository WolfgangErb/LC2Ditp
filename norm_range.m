function [x,y] = norm_range(x,y,raold,range)

% This function normalizes the range of the vectors x,y from
%          [raold(1), raold(2)]x[raold(3),raold(4)] to
%          [range(1), range(2)]x[range(3),range(4)]

% normalize the range to [0,1]x[0,1]
x = (x - raold(1)) / (raold(2) - raold(1));
y = (y - raold(3)) / (raold(4) - raold(3));

% map [0,1]x[0,1] to [range(1), range(2)]x[range(3),range(4)]
x = (x*(range(2)-range(1))) + range(1);
y = (y*(range(4)-range(3))) + range(3);

end

