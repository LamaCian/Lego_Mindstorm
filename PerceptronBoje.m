%Kreiranje perceptrona za prepoznavanje crne i bele boje na osnovu podataka
%dobijenih pomocu optickog senzora LEGO robota

%BOJE : ovo su obucavajuci parovi za boje koje smo smo dobili od optickog
%senzora kretanjem robota po tamnim i svetlim povrsinama
% i=parovi;
% o=izlaz;


i = [5 10 30 70 80 90];
o = [0 0 0 1 1 1];
perceptron_net = perceptron;
perceptron_net = train(perceptron_net,i,o);
view(perceptron_net);
% Cuvanje mreze
save 'D:\MASTER-MAS\LEGO\BOJE\PerceptronNet.mat' perceptron_net i o;

% Ucitavanje mreze
load 'D:\MASTER-MAS\LEGO\BOJE\PerceptronNet.mat';
% Provera na podacima... napraviti testni niz ulaznih ocitavanja boja sa 
% raznih podloga u vektor pa onda testirati, ovo testira samo za broj 25
y = perceptron_net(25);

% perceptron_net.iw{1,1} = [-1.2 -0.5];
% perceptron_net.b{1} = 1;
plotpc(perceptron_net.iw{1,1},perceptron_net.b{1})