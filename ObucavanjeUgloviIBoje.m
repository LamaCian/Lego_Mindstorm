
%UGLOVI : ovo su obucavajuci parovi za uglove koje smo prvo kreirali
%rotirajuci robota
 input=[4,13,22,31,41,52,61,70,78,89,99,106,118,128,135,147,153,168,-15,-35,-53,-71,-89,-106,-126,-142,-162,223,-220];
 output=[10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,-20,-40,-60,-80,-100,-120,-140,-160,-180,250,-250];
input=input.*-1;
output=output.*-1;
 i=input;
o=output;

 %UGLOVI sa testnim podacima: ovo su obucavajuci parovi za uglove koje smo prvo kreirali
%rotirajuci robota
% itest=[];
% otest=[];
% iobuc=[];
% oobuc=[];
% for index = 1: length(i)
%     if mod(index, 5) == 0
%         itest = [itest,i(index)];
%         otest = [otest,o(index)];
%     else
%         iobuc = [iobuc, i(index)];
%         oobuc = [oobuc, o(index)];
%     end   
%         
% end

% i=iobuc;
% o=oobuc;
 
%BOJE : ovo su obucavajuci parovi za boje koje smo smo dobili od optickog
%senzora kretanjem robota po raznim povrsinama
% i=parovi;
% o=izlaz;

% %skaliranje podataka
% i=mapminmax(input);
% o=mapminmax(output);

% Inicijalizacija mreze
vektor_broj_slojeva = [2,4];
vektor_broj_cvorova =[2,4,8,12,15];
vektor_algoritmi_ucenja = {'trainlm', 'trainbr', 'traingdx','traingd'};
vektor_aktivacione_funkcije = {'tansig','logsig','poslin'};
learning_rates = [0.1, 0.9];
index = 0;
tempTable = table(); %tabela u kojoj cemo cuvati podatke o svim obucenim mrezama
T=table();
for al = 1: max(size(vektor_algoritmi_ucenja))
    for bs =1: max(size(vektor_broj_slojeva))
        for af = 1: max(size(vektor_aktivacione_funkcije))
            for lrr = 1: max(size(learning_rates))
                index=index+1;
                broj_slojeva = vektor_broj_slojeva(bs);
                broj_cvorova = randsample(vektor_broj_cvorova,broj_slojeva , true);
                algoritam = vektor_algoritmi_ucenja(al);
                akt_funkcija = vektor_aktivacione_funkcije(af);
                aktivacione_funkcije = repmat( akt_funkcija, [1,broj_slojeva] );
                learning_rate = learning_rates(lrr);
                net = newff(i,o,broj_cvorova,aktivacione_funkcije, algoritam{1});
                net.trainParam.show = 100;
                net.trainParam.lr = learning_rate;
                net.trainParam.mu = learning_rate;%ako je trainlm
                net.trainParam.epochs = 200;
                net.trainParam.goal = 1e-3;
                net.divideParam.trainRatio = 0.7;
                net.divideParam.valRatio = 0.15;
                net.divideParam.testRatio = 0.15;
                
                % Treniranje mreze
                [net,tr] = train(net,i,o);
                rezultati(index)=tr.best_tperf;
                sve_mreze(index)={net}  ;      
                sve_mreze_tr(index)={tr};

%                 % Popunjavamo tabelu
%                 tempTable.algoritmi = algoritam;
%                 tempTable.aktFunkcija = akt_funkcija;
%                 tempTable.brojSlojeva = broj_slojeva; 
%                 tempTable.brojCvorova = mat2cell(broj_cvorova,1,broj_slojeva);
%                 tempTable.learningRates = learning_rate;
%                 tempTable.bestEpoch = tr.num_epochs;
%                 tempTable.time = tr.time(end);
%                 tempTable.trainPerformance =tr.best_perf; 
%                 tempTable.valPerformance = tr.best_vperf;
%                 tempTable.testPerformance = tr.best_tperf; 
%                 
% 
%                 T = [T;tempTable];
            end
        end
    end
end
[a b] = min(rezultati)
najbolja_mreza = sve_mreze{b}
trr = sve_mreze_tr{b}

% % Cuvanje svih mreza
% save 'D:\MASTER-MAS\LEGO\UGLOVI_TEST\SveMreze.mat' sve_mreze;
% % Cuvanje detalja o svim mrezama
% save 'D:\MASTER-MAS\LEGO\UGLOVI_TEST\SveMrezeTR.mat' sve_mreze_tr;
% % Cuvanje tabele performansi
% save 'D:\MASTER-MAS\LEGO\UGLOVI_TEST\Tabela.mat' T;
% % Cuvanje najbolje mreze
% save 'D:\MASTER-MAS\LEGO\UGLOVI_TEST\NajboljaMrezaIzmenjeni.mat' najbolja_mreza b;

y = sim(najbolja_mreza, i);
e = gsubtract(o, y); %greska - razlika tacnih i rezultata mreze
% figure, plotperform(trr); 
% figure, plottrainstate(trr);
% figure, ploterrhist(e);
% figure, plotregression(o,y);
figure, plot(o);
hold on
plot(y);

% za testiranje sa odvojenim skupom za test
% y = sim(najbolja_mreza, itest);
% e = gsubtract(otest, y); %greska - razlika tacnih i rezultata mreze
% figure, plotperform(trr); 
% figure, plottrainstate(trr);
% figure, ploterrhist(e);
% figure, plotregression(otest,y);
% figure, plot(otest);
% hold on
% plot(y);
% save 'D:\MASTER-MAS\LEGO\UGLOVI_TEST\RezultatiIParovi.mat' itest otest iobuc oobuc y e;
% 


