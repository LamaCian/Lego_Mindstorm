function [Tow(1:2,4)]=opticki_senzor_u_w(x,y,teta)
a=9; b=0; fi=0;
Tor=[cos(fi) -sin(fi) 0 a; sin(fi) cos(fi) 0 b; 0 0 1 0; 0 0 0 1];
Trw=[cos(teta) -sin(teta) 0 x; sin(teta) cos(teta) 0 y; 0 0 1 0; 0 0 0 1];
Tow=Trw*Tor
