function [x,C] = modelkretanja2(x, C, dsl, dsr, b, Cu)

ds = (dsl + dsr)/2;
dtheta = (dsr - dsl)/b;
theta = x(3);

% motion model Jacobian => [dp/dx dp/dy dp/dtheta]

M = [ 1 0 -ds*sin(theta + dtheta);...
    0 1 ds*cos(theta + dtheta);...
    0 0 1];

% Jacobian of controls => [dp/dsleft dp/dsright]

V = [ 1/2*cos(theta + dtheta) + 1/2*ds/b*sin(theta + dtheta)     1/2*cos(theta + dtheta) - 1/2*ds/b*sin(theta + dtheta);...  
    1/2*sin(theta + dtheta) - 1/2*ds/b*cos(theta + dtheta)       1/2*sin(theta + dtheta) - 1/2*ds/b*cos(theta + dtheta);...
    -1/b 1/b];

% Predict robot's state 
% State vector - first moment 

p = [ds*cos(theta + dtheta);
ds*sin(theta + dtheta);
dtheta];

x = x + p;

% Coovariance matrix - second moment

C = M*C*M' + V*Cu*V';


