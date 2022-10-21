% opticki senzor (light sensor) ocitavanje - testiranje
% obavezno napisati za koju boju se vrsi merenje!
% npr bela_boja

clc,clear
close all
handle = COM_OpenNXT('USB.ini', 'check');
COM_SetDefaultNXT(handle);
OpenLight(SENSOR_1,'ACTIVE');

S = []
%kmax = 1000
kmax=100 %dovoljno za treniranje mreze u okruzenju

for k = 1 : kmax
    s = GetLight(SENSOR_1)
    S = [S;s]
end

% obavezno napisati za koju boju se vrsi merenje!
% npr bela_boja = S

figure(1),
plot(S,'ob','MarkerSize',3,'MarkerFaceColor','b'),hold on,
xlabel('Number of examples')
ylabel('Measured light ntensity')
title('Training set for color detection')
h = legend('Test points',1);

crna_boja_5_okruzenje=S
save crna_boja_5_okruzenje