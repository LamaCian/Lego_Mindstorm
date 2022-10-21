function[Putanja] = a_zvezda1(matrica_okruzenja,i_start, j_start, i_cilj, j_cilj)



matrica_okruzenja = matrica_okruzenja*100;
[vrste, kolone] = size(matrica_okruzenja);

f = zeros( vrste, kolone,);
g = zeros(vrste,kolone,);
p=0;

Putanja = [i_start, j_start];
[h] = menhetn_norma(vrste,kolone,i_cilj, j_cilj)
h
% 
% %Prepreka = [...
%     1    1     1     1     1     1     1     1     1     1
%     1     0     0     0     0     0     0     0     0     1
%     1     0     0     0     1     1     1     0     0     1
%     1     0     1     1     0     0     0     0     0     1
%     1     0     1     1     0     0     0     0     0     1
%     1     1     1     1     0     0     1     0     0     1
%     1     1     1     1     0     0     0     0     0     1
%     1     1     1     1     1     1     1     1     1     1]*100;


 for i=1:vrste
     for j=1:kolone
    if (i_start == i_cilj) && (j_start == j_cilj)
        break
    else
 
[f, i_start, j_start, g, p] = menh(i_start, j_start, h, g, f, matrica_okruzenja, p );   
 Putanja = [Putanja; i_start, j_start];
    end
     end
 end


%  plot(pp(:,2),pp(:,1), '+r','Linewidth',1.4)
%  
%  grid on
%  
%  axis([0 n 0 m])
%  
%  title('putanja')
end








    