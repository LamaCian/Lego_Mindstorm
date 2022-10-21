function [putanja ] = a_zvezda_algoritam(matrica_okruzenja, start_x, start_y, cilj_x,cilj_y, norma)
% a_zvezda_algoritam Iscrtava kretanje sa pocetnom pozicijom (start_x, start_y) i
%   ciljem (cilj_x,cilj_y) u okruzenju datom matrica_okruzenja gde su sa 0
%   oznaceni moguci polozaji a sa 1 prepreke
%   ULAZ: matrica_okruzenja
%                       - 0 slobodan prolaz
%                       - 1 prepreka
%       start_x, start_y - startna pozicija
%       cilj_x, cilj_y - cilj

matrica_okruzenja = matrica_okruzenja*100;
[broj_vrsta, broj_kolona] = size(matrica_okruzenja);

H = matrica_heuristika(norma, broj_vrsta, broj_kolona, cilj_x, cilj_y);

% matrica cena za svaki cvor, pre racunanja su sve beskonacne (tj.100 :D)
G= 100*ones(broj_vrsta,broj_kolona);
% ukupna matrica cena sa pridruzenim heuristikama, pre racunanja su sve beskonacne (tj.100)
F= 100*ones(broj_vrsta, broj_kolona);
%  postavljamo tekuci cvor na start
tekuca_x = start_x;
tekuca_y = start_y;
%predjeni put od startne tacke,cena od starta do starta je 0
G(start_x, start_y) = 0; 
%za_crtanje= ones(broj_vrsta,broj_kolona);
predjene_tacke= zeros(broj_vrsta, broj_kolona);
predjene_tacke(start_x, start_y) = 100;
mapa_roditelja= zeros(broj_vrsta, broj_kolona);

% petlja u kojoj racunamo vrednosti F svih potencijalnih tacaka na nasoj
% putanji
        while ((tekuca_x ~= cilj_x) || (tekuca_y ~= cilj_y))
            %racunamo pocetne i krajnje koordinate okoline nase tacke
            %trenutne
            x_poc= max(1,(tekuca_x-1));
            x_kraj=min(broj_vrsta,(tekuca_x+1));
            y_poc=max(1,(tekuca_y-1));
            y_kraj=min(broj_kolona,(tekuca_y+1));
            %obelezavamo tekucu da smo je posetili
            predjene_tacke(tekuca_x, tekuca_y) = 100;
            % za okolinu nase trenutne tacke racunamo cenu za svaku
            % racunajuci zadatu normu i cenu dolaska do tekuce i raspored
            % prepreka i onda racunamo F- konacnu vrednost uracunavajuci i
            % heuristiku
            for i = x_poc:x_kraj
                for j= y_poc:y_kraj
                    if (norma == 'C')
    %                   #SaCasa
                        broj_dijagonalnih = min(abs(i-tekuca_x),abs(j-tekuca_y));
                        cena = 1.4*broj_dijagonalnih + abs(i-tekuca_x)-broj_dijagonalnih +abs(j-tekuca_y)-broj_dijagonalnih;
                        cena= cena+ G(tekuca_x,tekuca_y)+ matrica_okruzenja(i,j);
                	elseif (norma == 'M')
    %                   #Menhetn
                        if(i~=tekuca_x && j~=tekuca_y)
                            continue;
                        else
                            cena = abs(tekuca_x - i)+ abs(tekuca_y-j)+ G(tekuca_x,tekuca_y)+ matrica_okruzenja(i,j);
                        end
                    else                   
    %                   #Euklidska
                        cena = sqrt((tekuca_x-i)^2+(tekuca_y-j)^2)+ G(tekuca_x,tekuca_y)+ matrica_okruzenja(i,j);

                    end
                    
                    if G(i,j) > cena
                        G(i,j)=cena;
                        mapa_roditelja(i,j)=tekuca_x*broj_vrsta + tekuca_y;%dodala
                    end
                    if i~=tekuca_x || j~=tekuca_y
                        F(i,j) = G(i,j) + H(i,j);
                    end
                end
            end
            %kandidat za sledecu tacku posmatranja je ona tacka sa
            %najmanjom vrednoscu F koja pritom nije vec posecena
            kandidati = max(F, predjene_tacke);
            minimum = min(min(kandidati));
            %ako su sve vrednosti u F 100 i vece, znaci da nema puta do
            %cilja
            if(minimum >=100)
                error('Nije moguce naci putanju');

            end
            %nalazim indeks prvog cvora sa minimalnom vrednoscu da bismo
            %njega sledeceg posetili !!! bitno to ne mora biti cvor susedan
            %tekucem!!!!
            [tekuca_x,tekuca_y]=find(kandidati == minimum,1, 'last');
            
%             za_crtanje(tekuca_x,tekuca_y)=3;
% %             plot(tekuca_x,tekuca_y,'or');
%             hold on;

        end
      
        %sada kada smo izracunali sve potrebne parametre, ocitavamo
        %najkracu putanju od cilja unazad
        tekuca_x = cilj_x;
        tekuca_y = cilj_y;
        putanja=[cilj_x, cilj_y];
        while ((tekuca_x ~= start_x) || (tekuca_y ~= start_y)) 
            if(mod(mapa_roditelja(tekuca_x,tekuca_y),broj_vrsta) == 0)
                roditelj_x = fix(mapa_roditelja(tekuca_x,tekuca_y)/broj_vrsta) - 1;
                roditelj_y= broj_vrsta;
            else
                roditelj_x = fix(mapa_roditelja(tekuca_x,tekuca_y)/broj_vrsta);
                roditelj_y= mod(mapa_roditelja(tekuca_x,tekuca_y),broj_vrsta);
            end
            tekuca_x = roditelj_x;
            tekuca_y = roditelj_y;
            putanja = [putanja ; tekuca_x, tekuca_y];
            
%             za_crtanje(tekuca_x,tekuca_y)=2;
% %             plot(tekuca_x,tekuca_y,'xb');
%             hold on;
        end 
        %dobili smo putanju od cilja do starta pa je obrnemo
        putanja=flip(putanja,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
% %CRTANJE MAPE OKRU�ENJA
% prepreke = matrica_okruzenja >= 100;
% cmap = [1 1 1;
%     1 0 0;
%     0 1 0;
%     0 0 1;
%     0 1 1
%     0 0 0
%     ];
% 
% grid off
% hold off
% figure(1)
% axis([0 broj_kolona 0 broj_vrsta])
% colormap(cmap)
% okruzenje = ones(broj_vrsta, broj_kolona);
% okruzenje(prepreke) = 6;
% okruzenje(start_x,start_y) = 5;
% okruzenje(cilj_x, cilj_y) = 4;
% imagesc(okruzenje)
% for a=1:broj_vrsta
%     for b=1:broj_kolona
%         text(b,a,num2str(H(a,b)),'HorizontalAlignment','center','Color', 'red')
%     end
% end
% title('Okru�enje')
% hold off
% grid off
%  figure(2)
% 
% colormap(cmap)
%  axis([0 broj_kolona 0 broj_vrsta])
% za_crtanje(prepreke) = 6;
% za_crtanje(start_x,start_y) = 5;
% za_crtanje(cilj_x, cilj_y) = 4;
% imagesc(za_crtanje)
% text(start_y,start_x,'S','HorizontalAlignment','center')
% text(cilj_y,cilj_x,'C','HorizontalAlignment','center')
% title('A* algoritam')

end


