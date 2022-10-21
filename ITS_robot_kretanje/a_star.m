%A_ZVEZDA

function [Put,Putanja]=a_star(xp,yp,xc,yc)

format short g

%usvojeno je da se koordinatni sistem nalazi u gornjem levom uglu, i X ide
%nadole a Y na desno.
%definisanje velicine matrice tj radnog prostora
    N=8; %po x
    M=8; %po y
%OBRATITI PAZNJU PRI POSTAVLJANJU STARTA I CILJA JER SE RADNI PROSTOR NALAZI U GRANICAMA [2,2] DO [(N-1),(M-1)] 
%pocetna tacka
  

%ciljna tacka
    

%vektori po x i y
    nx=1:N;
    ny=1:M;

%Izracunavanje h za celu matricu prema Euklidskoj normi
for i=1:N
    for j=1:M
   h(i,j)=sqrt((nx(i)-xc)^2+(ny(j)-yc)^2);
    end
end
% punim matricu resenjima iz petlje
    H=h;
%Definisanje mesta na kojima se nalaze prepreke
%eventualno treba promeniti nule na mestima gde se nalazi prepreka
P=[1000 1000 1000 1000 1000 1000 1000 1000; 
    1000 0 0 0 0 0 0 1000;
    1000 0 0 100 100 0 0 1000;
    1000 0 0 100 100 0 0 1000;
    1000 0 0 0 0 0 0 1000;
    1000 0 0 0 0 0 0 1000;
    1000 0 0 0 0 0 0 1000;
    1000 1000 1000 1000 1000 1000 1000 1000;];
%Startna tacka postaje prva trenutna tacka u maloj petlji
    xt=xp;
    yt=yp;
%Definisanje predjenog puta
    pp=0;
    f=zeros(N,M);
    minf=2000;
    Put=[xp yp];
while 1
      
% dodeljivanje vrednosti g
 for k=xt-1:xt+1
    for l=yt-1:yt+1
        if k==xt & l==yt
            g(k,l)=0;
        elseif k==xt | l==yt
            g(k,l)=0.5;
        else
            g(k,l)=0.7072;
        end
    end
end
%    g;
%     G=g(k,l)
%     pp=pp+g(k,l)

% racuna f za okolna polja po osmospojivom okruzenju
  for k=xt-1:xt+1
    for l=yt-1:yt+1
        if f(k,l)>0
           %opcija continue u slucaju ispunjenog uslova nastavlja dalje
           %preskacuci ostatak petlje
        continue
        elseif k==xt & l==yt
            f(k,l)=H(k,l)+pp;
        %elseif k<N & k>1 & l<M & l>1
            %f(k,l)=H(k,l)+P(k,l)+g(k,l)+pp;
        else
            f(k,l)=H(k,l)+P(k,l)+g(k,l)+pp;
            
        end
    end
end
    f;
    

%provera minimuma f
    %minf= - realmax;
       
        for k=xt-1:xt+1
            for l=yt-1:yt+1
                %minf ne moze nikada da bude f(xt,yt)
                if (k==xt & l==yt)
                    continue
                    %minf=f(k,l);
                elseif minf>f(k,l)
                    minf=f(k,l);
                    K=k;
                    L=l;
                end
            end
        end
        
    minf;
%dodeljivanje nove vrednosti za sledece trenutno x
pp=pp+g(K,L);
xt=K;
yt=L;
Put=[Put; xt yt]
 if  (xt==xc & yt==yc)
     break
 end
 
end
H;
P;
f;
g;
Putanja=Put-2;
% PRIKAZIVANJE PUTANJE ROBOTA GRAFICKI
%plot
figure(2)
plot(Put(:,2),Put(:,1),'-*r') %na vertikalnoj osi X, a na horizontalnoj osi Y
%ukljucena mreza
grid on
%naziv grafika
title('PUTANJA LEGO ROBOTA PO A*')
%podesavanje x i y osa (fitovanje)
axis([0 N 0 M])
%gridovanje je podeseno po tackama
axis square
%plot pokazan kako je predvidjen radni prostor
axis ij