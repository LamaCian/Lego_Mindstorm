function [pose, Cov] = EKF_update_light_sensors(pose, C, z, zp, H, Q)

if isempty(zp) || isempty(z)
    return
else
    invec = z - zp;s
    CHt = C*H';
    S = H*CHt + Q;
    Sinv = inv(S);
    K = CHt*Sinv;
    up= K*invec;
    pose = pose + up;
    Cov = (eye(3) - K*H)*C;
end