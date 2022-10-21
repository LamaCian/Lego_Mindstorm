%VESTACKA NEURONSKA MREZA ZA BOJE SNIMLJENE U OKRUZENJU

clc,clear all

load bela_boja_1_okruzenje;
load bela_boja_2_okruzenje;
load bela_boja_3_okruzenje;
load bela_boja_4_okruzenje;
load bela_boja_5_okruzenje;
load crna_boja_1_okruzenje;
load crna_boja_2_okruzenje;
load crna_boja_3_okruzenje;
load crna_boja_4_okruzenje;
load crna_boja_5_okruzenje;

% black =  [crna_boja_4_okruzenje(400:500); crna_boja_3_okruzenje(650:750) ];
% 
% white = [bela_boja_1_okruzenje(650:750); bela_boja_3_okruzenje(400:500) ];

black =  [crna_boja_4_okruzenje; crna_boja_3_okruzenje];

white = [bela_boja_1_okruzenje; bela_boja_3_okruzenje];

x = [black;white];

xi = (x - (max(x)+min(x))./2)./((max(x)-min(x))./2) %definise belu u blizini 1, a crnu u blizini -1

figure(1),
plot(white,'ob','MarkerSize',3,'MarkerFaceColor','b'),hold on,
plot(black,'ok','MarkerSize',3,'MarkerFaceColor','k')
xlabel('Number of examples')
ylabel('Measured light ntensity')
title('Training set for color detection')
h = legend('Black color','White color',1);

%==========================================================================
% Modeling with feedforward neural network
x1 = xi(1:size(black,1)) %ulaz za crnu - blizu -1 
x2 = xi(size(black,1)+1:end) %ulaz za belo - blizu 1 

o1 = ones(size(black,1),1)*-1 %izlaz za crnu je -1
o2 = ones(size(white,1),1) %izlaz za belu je 1

opt_sens_boje_okruzenjeff = newff([x1;x2]',[o1;o2]',[2],{'tansig'},'trainlm')

%Parametri neuronske mreze
opt_sens_boje_okruzenjeff.trainParam.show = 50;
opt_sens_boje_okruzenjeff.trainParam.lr = 0.05;
opt_sens_boje_okruzenjeff.trainParam.mc = 0.9;
opt_sens_boje_okruzenjeff.trainParam.mu = 0.001
opt_sens_boje_okruzenjeff.trainParam.epochs = 1000;
opt_sens_boje_okruzenjeff.trainParam.goal = 1e-5;
opt_sens_boje_okruzenjeff.trainParam.max_fail = 10;

opt_sens_boje_okruzenjeff = train(opt_sens_boje_okruzenjeff,[x1;x2]',[o1;o2]')

% Verify network's performance
Yp = sim(opt_sens_boje_okruzenjeff,[x1;x2]')'
% Variance of FFNN model is:
sff2 = (1/length(x))*sum(([o1;o2] - Yp).^2) %varijansa sigurnosti


save opt_sens_boje_okruzenjeff


