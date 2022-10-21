clc,clear
x = [10 0 90/57.3]'
C = eye(3)

Q = [.1 0;0 .1]

map = [12 5; 11 3;18 5;1 0;10 10]

N = []
e = 1

for k = 1 : size(map,1)
%     na ovom mestu (umesto predict_measurements_with_lihgt_sensors() ) 
% stavite vasu funkciju koja predvidja merenja
    [xs,ys,Hp] = predvidjanje_merenja(x(1), x(2), x(3))
    zp=[xs;ys]
    z = map(k,:)'
    S= Hp*C*Hp' + Q;
    %     very very very simple association....
    nis= (z-zp)'*inv(S)*(z-zp);
    N = [N;nis]
end

j = find(N<=e)
if isempty(j)
    return
else
    Z = map(j,:)'
    [x, C] = EKF_update_light_sensors(x, C, Z, zp, Hp, Q)
end

