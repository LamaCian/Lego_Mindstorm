function[h] = norma_sa_casa(m, n, i_cilj, j_cilj)
for i= 1:m
  for j= 1:n
  
%       #SaCasa
        broj_dijagonalnih = min(abs(i-i_cilj),abs(j-j_cilj));
        h(i,j) = 1.4*broj_dijagonalnih + abs(i-i_cilj)-broj_dijagonalnih +abs(j-j_cilj)-broj_dijagonalnih;

  end  
end
end

