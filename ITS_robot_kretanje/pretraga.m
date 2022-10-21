function [posecen,matrica_okruzenja] = pretraga(posecen, matrica_okruzenja, dfs,n,m)


dx =[-1, 1, 0,  0];
dy =[ 0, 0, 1, -1];

if dfs
    xy = posecen(end,[1:end]);
else
    xy = posecen(1, [1:end]);
end
x=xy(1);
y=xy(2);
if (matrica_okruzenja(x,y) ~= 0)
    if dfs
        posecen(end,:)= [];
    else
        posecen(1,:) = [];
    end
else
    min = 10000;
    for i = 1:4
        newX = x + dx(i);
        newY = y + dy(i);
        
        if (~(newX>n || newX<1 || newY > m || newY <1))
            
            if matrica_okruzenja(newX, newY) > 0 
                if matrica_okruzenja(newX, newY) < min
                    min = matrica_okruzenja(newX, newY);
                end
            else
                posecen = [posecen; newX, newY];
            end
        end
        
       
    end
    
    if min == 10000 
        min = 0;
    end

    matrica_okruzenja(x,y) = min + 1;
   
end
end
% putanja = [i_cilj, j_cilj]
%  i_trenutno = i_cilj
%     j_trenutno = j_cilj
%     
%     
%     while (i_trenutno ~= i_start || j_trenutno ~= j_cilj)
%       
%            
%       
%     putanja = [putanja; i_trenutno, j_trenutno]
%     
 


