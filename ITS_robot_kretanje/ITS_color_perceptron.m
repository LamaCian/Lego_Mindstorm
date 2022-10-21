

% =========================================================================
% Modeling with perceptron

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

b = crna_boja1(300:400); w = bela_boja3(400:500);

p1 = [b' w']
t = [zeros(size(b,1),1)' ones(size(w,1),1)']
[p,c] = mapminmax(p1)
netperc = newp(p,t);

netperc = train(netperc,p,t)
a = sim(netperc,p)
test = p1
Yp = []

p2 = 300 % testing performance of netperc
for k = 1 : length(test)


    y2 = mapminmax('apply',test(k),c)

    yp = sim(netperc,y2)

    Yp = [Yp; yp]

end

% Variance of perceptron NN model is:

sp2 = (1/length(p1))*sum((t' - Yp).^2)

% save netperc