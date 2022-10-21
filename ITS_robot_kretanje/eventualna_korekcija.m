function [x,C] = eventualna_korekcija(mycolorsensor, net_Boje, x, C, Q, mapa1) 
%eventualna_korekcija - cita sa optickog senzora i procenjuje boju na
%osnovu obucene mreze za prepoznavanje crne i bele boje i vraca novi
%procenjeni polozaj i matricu kovarijansi ukoliko senzor vrati informaciju
%da je naisao na marker

       s = readLightIntensity(mycolorsensor,'reflected');
       ocitana_boja =sim(net_Boje,double(s));
%        svaOcitavanjaSenzora = [svaOsvaOcitavanjaSenzora; ocitana_boja];
       if round(ocitana_boja) == 0
          [x,C] = korigovanje_polozaja(x,C,Q,mapa1); 
       end  
end

