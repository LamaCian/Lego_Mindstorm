function[H] = matrica_heuristika(norma, broj_vrsta, broj_kolona, cilj_x, cilj_y)
%   ULAZ: norma         - 'C' Sa casa
%                       - 'M' Menhetn
%                       - 'E' Euklidska
for i=1:broj_vrsta
    for j=1:broj_kolona
        
    if (norma == 'C')
%         #SaCasa
        broj_dijagonalnih = min(abs(i-cilj_x),abs(j-cilj_y));
        H(i,j) = 1.4*broj_dijagonalnih + abs(i-cilj_x)-broj_dijagonalnih +abs(j-cilj_y)-broj_dijagonalnih;
    elseif (norma == 'M')
%         #Menhetn
          H(i,j) = abs(cilj_x - i)+ abs(cilj_y-j); 
    else 
%         #Euklidska
          H(i,j) = sqrt((cilj_x - i)^2+(cilj_y-j)^2);                
     end
    end
end
end

