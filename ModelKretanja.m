function [predjeniPutevi, polozajiRobota ] = ModelKretanja()
% ModelKretanja Iscrtava kretanje robota sa pocetnom pozicijom (x, y) i

    %ucitavanje najbolje obucene mreze za uglove
    load 'D:\MASTER-MAS\LEGO\UGLOVI\NajboljaMreza.mat'
    
    % Uspostavljanje komunkacije sa upravljackom jediniciom preko usb
    myev3 = legoev3('usb');
    
    razmakTockova = 113; %Rastojanje izmedju tockova
    poluprecnik = 21.5;% PRECNIK TOCKA U MM

    %Komunkiacija sa motorom, u koji je motor prikljucen ("A", "C")
    mymotor1 = motor(myev3, 'A');
    mymotor2 = motor(myev3, 'D');

    % Resetovanje enkodera - Vracanje na 0
    resetRotation(mymotor1);
    resetRotation(mymotor2);

    SPEED =30;

    mymotor1.Speed = SPEED; % Podesavanje brzine motora
    mymotor2.Speed = -SPEED;
    
    predjeniPutevi = zeros(100,2);
    
    %trazimo ugao koji treba da zadamo da bismo dobili rotaciju za 90
    %stepeni
    ugao = sim(najbolja_mreza, 90);
    
    for i=1:100
        if(mod(i,25) == 0)
            [r1, r2] = Rotate(ugao, mymotor1, mymotor2);
        else
            [r1, r2] = GoStraight(10, mymotor1, mymotor2 );
        end
        s1 = poluprecnik* pi* r1/180;
        s2 = poluprecnik* pi* r2/180;
        predjeniPutevi(i,:) = [s1, s2];
        pause(0.2)
    end
    
%     predjeniPutevi = GetPutanjaSquare(10, razmakTockova);

    [rows columns] = size(predjeniPutevi);
%     s1 = poluprecnik* pi* r1/180;
%     s2 = poluprecnik* pi* r2/180;
%     predjeniPutevi(1,:) = [s1, s2];
%         
    polozajiRobota = zeros(rows,3);
    x=0; y=0; theta=pi/2;
    %izracunavanje kretanja robota
    for i = 1 : rows        
        x = x + ((predjeniPutevi(i,1)+predjeniPutevi(i,2))/2)*(cos(theta+(predjeniPutevi(i,2)-predjeniPutevi(i,1))/(2*razmakTockova)));
        y = y + ((predjeniPutevi(i,1)+predjeniPutevi(i,2))/2)*(sin(theta+(predjeniPutevi(i,2)-predjeniPutevi(i,1))/(2*razmakTockova)));
        theta = theta + (predjeniPutevi(i,2) - predjeniPutevi(i,1))/razmakTockova;
        polozajiRobota(i,:) = [x, y, theta];    
        
    end

    minX=round(min(polozajiRobota(:,1)));
    maxX=round(max(polozajiRobota(:,1)));
    minY=round(min(polozajiRobota(:,2)));
    maxY=round(max(polozajiRobota(:,2)));

    for i = 1 : rows
        %postavljanje podeoka na osama i domena
        figure(1);
        xticks(minX-50 : round((maxX-minX)/10)+1: maxX+50);
        yticks(minY-50 :round((maxY-minY)/10)+1: maxY+50);
        xlim([minX-50  maxX+50]);
        ylim([minY-50  maxY+50]);
        line([0,0], ylim);
        line(xlim, [0,0]);
%         title(strcat('Kretanje robota po zadatoj trajektoriji ',naslov), 'FontSize',10);
        plot(polozajiRobota(i,1), polozajiRobota(i,2), '-o', 'MarkerSize', 5);
        hold on;
        grid on;
    end
end



