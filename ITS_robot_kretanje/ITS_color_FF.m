
clc,clear all

load bela_boja1;
load bela_boja2;
load bela_boja3;
load bela_boja4;
load bela_boja5;
load crna_boja1;
load crna_boja2;
load crna_boja3;
load crna_boja4;
load crna_boja5;

black =  [crna_boja4(400:500); crna_boja3(650:750) ];

white = [bela_boja1(650:750); bela_boja3(400:500) ];

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

opt_sens_prepoznavanje_bojeff = newff([x1;x2]',[o1;o2]',[2],{'tansig'},'trainlm')

%Parametri neuronske mreze
opt_sens_prepoznavanje_bojeff.trainParam.show = 50;
opt_sens_prepoznavanje_bojeff.trainParam.lr = 0.05;
opt_sens_prepoznavanje_bojeff.trainParam.mc = 0.9;
opt_sens_prepoznavanje_bojeff.trainParam.mu = 0.001
opt_sens_prepoznavanje_bojeff.trainParam.epochs = 1000;
opt_sens_prepoznavanje_bojeff.trainParam.goal = 1e-5;
opt_sens_prepoznavanje_bojeff.trainParam.max_fail = 10;

opt_sens_prepoznavanje_bojeff = train(opt_sens_prepoznavanje_bojeff,[x1;x2]',[o1;o2]')

% Verify network's performance
Yp = sim(opt_sens_prepoznavanje_bojeff,[x1;x2]')'
% Variance of FFNN model is:
sff2 = (1/length(x))*sum(([o1;o2] - Yp).^2) %varijansa sigurnosti


save opt_sens_prepoznavanje_bojeff


