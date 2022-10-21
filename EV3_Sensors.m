%TEST SENZORA
% Uspostavljanje komunkacije sa upravljackom jediniciom
myev3 = legoev3('usb');

% COLOR SENZOR - OPTICKI SENZOR

mycolorsensor = colorSensor(myev3); % Uspostavljanje komunkacije sa color senzorom

color = readColor(mycolorsensor); %u promeljivu "color" pise naziv boje

%Osvetljenje
intensity = readLightIntensity(mycolorsensor); % Ocitavanje inteziteta svetlosti

% Vrednost reflektovane svetlosti
Ref_intensity = readLightIntensity(mycolorsensor,'reflected');

for i=1:30
    Ref_inte=readLightIntensity(mycolorsensor,'reflected')
     pause(0.2)
end     

% INFRA RED SENZOR - PROKSIMITI SENZOR - SENZOR DUZINE

myirsensor = irSensor(myev3); %Komunkacija sa IR senzorom

Distance=readProximity(myirsensor); % Ocitanje distance u cm

for i=1:30
    Dis=readProximity(myirsensor)
    pause(0.2)
end


% TOUCH senzor 

mytouchsensor = touchSensor(myev3);% Komunkacija

PUSH=readTouch(mytouchsensor); % 1 za pritisnuto
                               % 0 za ne pritisnuto
                               
                               
for i=1:30
    PUSH=readTouch(mytouchsensor)
     pause(0.2)
end                               
                               




