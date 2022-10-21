function [polozaj_robota,C] = nas_model_kretanja(polozaj_robota, C, dsl, dsr, razmakTockova, M)

    x=polozaj_robota(1);
    y=polozaj_robota(2);
    theta=polozaj_robota(3);

    ds= (dsr+dsl)/2;
    dtheta=(dsr - dsl)/razmakTockova;

    x = x + ((dsl+dsr)/2)*(cos(theta+(dsr-dsl)/(2*razmakTockova)));
    y = y + ((dsl+dsr)/2)*(sin(theta+(dsr-dsl)/(2*razmakTockova)));
    theta = theta + (dsr - dsl)/razmakTockova;   

    
    G = [ 1 0 -(ds)*sin(theta + (dtheta/2));
        0 1  (ds)*cos(theta + (dtheta/2));
        0 0   1];
    
    V = [ cos(theta+dtheta/2)/2+ds*sin(theta+dtheta/2)/(2*razmakTockova)   cos(theta+dtheta/2)/2-ds*sin(theta+dtheta/2)/(2*razmakTockova);
          sin(theta+dtheta/2)/2-ds*cos(theta+dtheta/2) /(2*razmakTockova)  sin(theta+dtheta/2)/2+ds*cos(theta+dtheta/2)/(2*razmakTockova);
          -1/razmakTockova       1/razmakTockova ];

    C = G*C*G' + V*M*V';

    polozaj_robota = [x, y, theta]';

end