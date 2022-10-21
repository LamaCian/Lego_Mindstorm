% odredjivanje AngleLimit i TurnRatio na osnovu NN modela

clc,clear
close all
% SetPower = const. = 20 => uvek!
% TurnRatio = 100 => pozitivan mat. smer = -100
%                    negativan mat. smer = 100

% Merenja su uradjena za sledece uglove: 
% +/- [15 -15 30 -30 45 -45 60 -60 90 -90 120 -120 150 -150 180 -180]


% AL = [20 20 60 45 100 85 100 100 200 170 270 225 340 280 395 340]
% input = [15 -15 30 -30 45 -45 60 -60 90 -90 120 -120 150 -150 180 -180]
% NAJDAN

AL = [40 50 70 70 100 100 130 160 180 180 210 220 240 260 250 300 300 350 320 390 350 420 400 450]
input = [15 -15 30 -30 45 -45 60 -60 75 -75 90 -90 105 -105 120 -120 135 -135 150 -150 165 -165 180 -180]
% NASE - GRUPA1
% % 

output = [AL]

%SCnet_PR = newff(input,output,[10],{'tansig'},'trainlm','learngdm') NAJDAN
SCnet_PR = newff(input,output,[10],{'tansig'},'trainlm','learngdm')

SCnet_PR.trainParam.show = 50;
SCnet_PR.trainParam.lr = 0.05;
SCnet_PR.trainParam.mc = 0.9;
SCnet_PR.trainParam.mu = 0.001
SCnet_PR.trainParam.epochs = 1000;
SCnet_PR.trainParam.goal = 1e-5;
SCnet_PR.trainParam.max_fail = 10;

SCnet_PR = train(SCnet_PR,input,output)
y = sim(SCnet_PR,input)

disp('y AL input ')
mreza_vs_AL=[y' AL' input' ]


figure(1),
plot(input,AL,'or'),hold on
plot(input,y,'b*')
% SCnet_PR2 = SCnet_PR
% save('SCnet_PR2','SCnet_PR2')

% subplot(2,1,1),plot(input,TR,'or'),hold on
% plot(input,y2,'b*')
% subplot(2,1,2),plot(input,AL,'or'),hold on
% plot(input,y1,'b*')