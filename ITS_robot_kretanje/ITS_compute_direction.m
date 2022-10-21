function [phi] = ITS_compute_direction(pose, cp)

    %[phi] = compute_direction(pose,checkpoint);
    % pose ==> [x y theta]'
    % checkpoint ==> [x y]'

alfa = atan2((cp(2) - pose(2)),(cp(1)-pose(1)));

phi = alfa - pose(3);

if phi >= pi
    phi = phi - 2*pi;
elseif phi <= -pi
    phi = phi + 2*pi;
end


end
