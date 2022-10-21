function d = ITS_compute_distance(pose, cp)
% 
% robot's distance to goal (checkpoint)
% pose ==> [x y theta]'
% checkpoint ==> [x y]'
%==========================================================================
dx = cp(1)-pose(1);
dy = cp(2)-pose(2);
d = sqrt((dx)^2 + (dy)^2);


end

