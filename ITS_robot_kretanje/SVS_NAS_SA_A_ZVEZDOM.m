%ova skripta je refaktorisan kod STVARNO_RADI_SVE koji treba da probamo kad
%budemo imali pristup robotu ponovo...
clc,clear,close all
% matrica_okruzenja=[ 
%     1 0 0 0 0 0 0 0 0 0 0  ;
%     0 0 0 0 0 0 0 0 0 0 0;
%     0 0 100 100 100 0 0 0 ;
%     0 0 100 100 100 0 0 0 
%     0 0 100 100 100 0 0 0 ;
%     0 0 0 0 0 0 0 0 ;
%     100 0 0 0 0 0 0 0 0;
%     0 100 0 0 0 0 0 0 ;
%     ];
matrica_okruzenja=zeros(16,22);
matrica_okruzenja( 6:10, 8:12)=100;
matrica_okruzenja( 1:2, 1:2)=100;
% ucitavamo najbolju mrezu za boje
load 'NajboljaMrezaBoje.mat'
net_Boje = najbolja_mreza;
%ucitavamo najbolju mrezu za uglove
load 'NajboljaMrezaIzmenjeni.mat'
Net_Rotacija = najbolja_mreza;

%tacke koje nas robot treba da prodje, zadate
%prva trajektorija
% xc = [4 12 12];
% yc = [4 6 14];
%druga trajektorija
%  xc = [4 3 13];
%  yc = [4 12 20];
pocetni_ugao=0;
xc = [3 4 12];
yc = [15 4 6];
% mapa1 = [20 12; 45 50; 20 85; 45 80]
  
% mapa1 = [25 22; 15 63; 30 55; 63 57; 65 103];

Xpiksel=5;
Ypiksel=5;%u cm
%%pocetak programa za kretanje

myev3 = legoev3('USB');
mycolorsensor = colorSensor(myev3);

mymotor1 = motor(myev3, 'A'); % Set up motor
mymotor2 = motor(myev3, 'D');

if myev3.BatteryLevel <= 70
    disp ('Baterija na manje od 70% dopuniti')
end

svaOcitavanjaSenzora= [];%yp - ovde skupljamo ocitane boje sa optickog senzora (crna ili bela)

polozaj = [xc(1)* Xpiksel yc(1)* Ypiksel pocetni_ugao/57.3]';%ovo nam je pocetni polozaj robota?

C = eye(3)*.1;% pocetna matrica kovarijansi

%za svaku tacku na unapred zadatoj putanji, odredi trajektoriju pomocu a*, zatim
%
for i=1:(length(xc)-1)
    %a* kreira putanju izmedju dve susedne zadate tacke koje robot treba da
    %obidje
    %Putanja = dfs_algoritam(matrica_okruzenja, xc(i), yc(i), xc(i+1), yc(i+1), 'E');
    Putanja = dfs(matrica_okruzenja, xc(i), yc(i), xc(i+1), yc(i+1));
    razmakTockova = 11.3;%113 koliko je bilo?
    poluprecnikTocka = 2.15;

    Q = [100 0; 0 100];
     mapa1 = [25 22; 15 63; 55 30; 63 57; 65 103];
%     mapa1 = [20 12; 45 50; 20 85; 45 80];%!ovo su markeri
%     mapa1 = [25 22; 55 29.5; 62.5 57; 15 68; 31 90; 64 102];%!
    
    pathx = Putanja(1:end, 1) * Xpiksel;%!
    pathy = Putanja(1:end, 2) * Ypiksel;%!
    
    %crtanje okruzenja i zeljene putanje
    figure(1)    
    %axis ([-20 110 -20 160]);
    plot_simulation_data(polozaj, C), hold on;    
    plot(pathx, pathy,'-*r','linewidth',4), hold on    
    okruzenje_jupiter; hold on    
    path=[pathx,pathy];
    
    % Precnik kruznice u cijoj toleranciji se robot mora naci
    % posle svakog translatornog kretanja
    tolerancija_rastojanja = 3; 
    % ugao do koga se vrsi rotacija, ukoliko je razlika manja, ne rotiramo
    tolerancija_ugla = 15;    
    
    %[x,C] = eventualna_korekcija(mycolorsensor, net_Boje, x, C, Q, mapa1); 
    
    %iteriramo kroz tacke putanje dobijene a* algoritmom za nase dve
    %susedne tacke iz polaznog skupa
    for k = 1 : size(path,1)
        rastojanje_do_sledece_tacke = ITS_compute_distance(polozaj, path(k,:));
        ugao_do_sledece_tacke = ITS_compute_direction(polozaj, path(k,:))*57.3;
        
        %u startu proveravamo ugao ka sledecoj tacki iz putanje iz a* i ako
        %odstupa za vise od tolerancija_ugla stepeni rotiramo ga ka tacki
        if abs(ugao_do_sledece_tacke) >= tolerancija_ugla            
            alrot = round(sim(Net_Rotacija,ugao_do_sledece_tacke));
            [MB,MC]=Rotate( alrot, mymotor1, mymotor2);
            stop(mymotor1, 0); % Stop motor
            stop(mymotor2, 0);
            
            dsl = MB/57.3*poluprecnikTocka;
            dsr = MC/57.3*poluprecnikTocka;
            
            M = [10^-5*abs(dsl) 0;0 10^-5*abs(dsr)];
            
            [polozaj, C] = nas_model_kretanja(polozaj, C, dsl, dsr, razmakTockova, M);
            [polozaj, C] = eventualna_korekcija(mycolorsensor, net_Boje, polozaj, C, Q, mapa1);
            
            rastojanje_do_sledece_tacke = ITS_compute_distance(polozaj, path(k,:));
            ugao_do_sledece_tacke = ITS_compute_direction(polozaj, path(k,:))*57.3;
        end%if
        
        %sada kada je robot usmeren ka sledecoj tacki do na
        %tolerancija_ugla stepeni, vrsimo translatorno kretanje u malim
        %koracima pravo uz proveru toga da li je ugao ka zeljenoj tacki
        %odstupio za vise od 2*tolerancija_ugla stepeni i ako jeste,
        %rotiramo ga ka zeljenoj tacki
        while rastojanje_do_sledece_tacke > tolerancija_rastojanja    
            %ukoliko ugao do sledece tacke ima vise stepeni od tolerancije
            if abs(ugao_do_sledece_tacke) >= 2 * tolerancija_ugla                
                alrot = round(sim(Net_Rotacija, ugao_do_sledece_tacke));%round zaokruzuje na celu vrednost        
                [MB, MC]=Rotate(alrot, mymotor1, mymotor2);  
            else     
                %ovde se ide 4 po 4 milimetra dok se ne dodje u tolerisano
                %okruzenje tacke do koje idemo
                [MB, MC]=GoStraight(4,mymotor1, mymotor2); % Podesiti iz koliko koraka robot predje zeljeni put
            end
            stop(mymotor1, 0); % Stop motor
            stop(mymotor2, 0);
   
            dsl = MB/57.3*poluprecnikTocka;
            dsr = MC/57.3*poluprecnikTocka;
            
            M = [10^-5*abs(dsl) 0;0 10^-5*abs(dsr)];
            
         [polozaj, C] = nas_model_kretanja(polozaj, C, dsl, dsr, razmakTockova, M);            
            plot_simulation_data(polozaj, C),hold on;
            
            [polozaj, C] = eventualna_korekcija(mycolorsensor, net_Boje, polozaj, C, Q, mapa1);
            
            rastojanje_do_sledece_tacke = ITS_compute_distance(polozaj, path(k,:));
            ugao_do_sledece_tacke = [polozaj, path(k,:)]*57.3;
            pause(0.1)
        end%while       
    end%for
end%for



