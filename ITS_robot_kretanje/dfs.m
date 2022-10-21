
function [Putanja] = dfs(matrica_okruzenja,i_start,j_start, i_cilj, j_cilj)



 matrica_okruzenja = matrica_okruzenja*100;
 [n, m] = size(matrica_okruzenja);
posecen =[i_start j_start];
i_trenutno = i_cilj
  j_trenutno = j_cilj 
Putanja = [i_cilj, j_cilj];
 

postignut = 0;

while ~isempty(posecen) && ~postignut
   
   [posecen,matrica_okruzenja] = pretraga(posecen, matrica_okruzenja, 0,n,m)
   

    if matrica_okruzenja(i_cilj,j_cilj) ~= 0
       postignut =1
    end
end


dx =[-1, 1, 0,  0];
dy =[ 0, 0, 1, -1];

  while (i_trenutno ~= i_start || j_trenutno ~= j_start)
      
      k = matrica_okruzenja (i_trenutno,j_trenutno)
      for i = 1:4
         komsijaX  = i_trenutno + dx(i);
        komsijaY = j_trenutno + dy(i);
        
      l = matrica_okruzenja(komsijaX, komsijaY)
       if l == k-1
           i_trenutno = komsijaX
           j_trenutno = komsijaY
           Putanja = [i_trenutno,j_trenutno;Putanja]
       end
      end
      
    
  end
  
   
  
%
% plot(posecen(:,2),posecen(:,1), '+r','Linewidth',1.4)
% grid on
%  axis([0 n 0 m])