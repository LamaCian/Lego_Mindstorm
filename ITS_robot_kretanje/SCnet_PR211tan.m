% odredjivanje AngleLimit i TurnRatio na osnovu NN modela

clc,clear
close all
% SetPower = const. = 20 => uvek!
% TurnRatio = 100 => pozitivan mat. smer = -100
%                    negativan mat. smer = 100

% Merenja su uradjena za sledece uglove: 
% +/- [15 -15 30 -30 45 -45 60 -60 90 -90 120 -120 150 -150 180 -180]

% NAJDAN
% AL = [20 20 60 45 100 85 100 100 200 170 270 225 340 280 395 340]
% input = [15 -15 30 -30 45 -45 60 -60 90 -90 120 -120 150 -150 180 -180]

% NASE - GRUPA1
AL = [40 50 70 70 100 100 130 160 180 180 210 220 240 260 250 300 300 350 320 390 350 420 400 450]
input = [15 -15 30 -30 45 -45 60 -60 75 -75 90 -90 105 -105 120 -120 135 -135 150 -150 165 -165 180 -180]

  
%ulazni vektor provere
input1=[-143 128 -117 -10 10 98 -57];

output = [AL]

%SCnet_PR = newff(input,output,[10],{'tansig'},'trainlm','learngdm') NAJDAN
SCnet_PR211t = newff(input,output,[8,6],{'tansig','tansig'},'trainlm','learngdm')

SCnet_PR211t.trainParam.show = 50;
SCnet_PR211t.trainParam.lr = 0.05;
SCnet_PR211t.trainParam.mc = 0.9;
SCnet_PR211t.trainParam.mu = 0.001
SCnet_PR211t.trainParam.epochs = 1000;
SCnet_PR211t.trainParam.goal = 1e-5;
SCnet_PR211t.trainParam.max_fail = 10;

SCnet_PR211t = train(SCnet_PR211t,input,output)
y = sim(SCnet_PR211t,input)
y1 = sim(SCnet_PR211t,45)%PR211tIMER ZA PR211tOBNI ULAZ 173 STEPENA; OZNACITI PA F9
y2 = sim(SCnet_PR211t,input1)%%PR211tIMER ZA PR211tOBNI ulazni vektor input1
disp('y AL input ')
mreza_vs_AL=[y' AL' input' ]


figure(1),
plot(input,AL,'or'),hold on % crveni(red) su obucavajuci parovi bez obucavanja mreze
plot(input,y,'b*',input1,y2,'g+') % plavi (blue) rezultati mreze za ulazni vektor obucavajuceg para

save SCnet_PR211t
%green rezultat mreze za nase (test) ulaze

% SCnet_PR211t2 = SCnet_PR211t
% save('SCnet_PR211t2','SCnet_PR211t2')

% subplot(2,1,1),plot(input,TR,'or'),hold on
% plot(input,y2,'b*')
% subplot(2,1,2),plot(input,AL,'or'),hold on
% plot(input,y1,'b*')