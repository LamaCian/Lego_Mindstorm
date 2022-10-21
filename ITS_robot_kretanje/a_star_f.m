
function [Put,Putanja]=a_star_f(xp,yp,xc,yc)

format short g

xz=xp;
yz=yp;
%usvojeno je da se koordinatni sistem nalazi u gornjem levom uglu, i X ide
%nadole a Y na desno.
%definisanje velicine matrice tj radnog prostora
    N=10; %po x
    M=10; %po y
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
P=[1000 1000 1000 1000 1000 1000 1000 1000 1000 1000; 
    1000 0 0 0 0 0 0 0 0 1000;
    1000 0 0 0 0 0 0 0 0 1000;
    1000 0 0 100 100 100 0 0 0 1000;
    1000 0 0 100 100 100 0 0 0 1000;
    1000 0 0 100 100 100 0 0 0 1000;
    1000 0 0 0 0 0 0 0 0 1000;
    1000 0 0 0 0 0 0 0 0 1000;
    1000 0 0 0 0 0 0 0 0 1000;
    1000 1000 1000 1000 1000 1000 1000 1000 1000 1000];
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
        if f(k,l)>0 %ako je vec izracunato nastavlja dalje
           %opcija continue u slucaju ispunjenog uslova nastavlja dalje
           %preskacuci ostatak petlje
            f(k,l)=f(k,l)+g(k,l); % continue  
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
                %elseif (k==xz & l==yz)
                    %continue
                elseif minf > f(k,l)
                    minf=f(k,l);
                    K=k;
                    L=l;
                end
            end
        end
        
     minf=2000;
%dodeljivanje nove vrednosti za sledece trenutno x
pp=pp+g(K,L);
xt=K;
yt=L;

Put=[Put; xt yt];

xz=xt;
yz=yt;

  if  (xt==xc & yt==yc)
      break
  end
 
 end
% H;
% P;
% f;
% g;
Putanja=Put-2;
% PRIKAZIVANJE PUTANJE ROBOTA GRAFICKI
%plot
% figure(2)
% %na vertikalnoj osi X, a na horizontalnoj osi Y
% %plot(Put(:,2),Put(:,1),'-*r','linewidth',2) 
% 
% xlabel(''),ylabel('x') 
% %ukljucena mreza
% grid on
% %naziv grafika
% title('PUTANJA LEGO ROBOTA PO A*')
% %podesavanje x i y osa (fitovanje)
% axis([1 N 1 M])
% %gridovanje je podeseno po tackama
% axis square
% %plot pokazan kako je predvidjen radni prostor
% axis ij
% %plotuje sve na jednom plotu
% hold on

%PLOTOVANJE OKVIRA
% OX=[1,1,10,10,1];
% OY=[1,10,10,1,1];
% plot(OX,OY,'-b','linewidth',3);
% 
% %PLOTOVANJE PREPREKA
% PX=[4,4,5,6,6,6,6,5,4,4,4];
% PY=[4,4,4,4,4,5,6,6,6,5,4];
% %PK=[2,3,4,5,6,7,8,7,6,5,4,3,2];
% %PV=[6,6,6,6,6,6,7,7,7,7,7,7,6];
% plot(PX,PY,'-b','linewidth',2.5);
