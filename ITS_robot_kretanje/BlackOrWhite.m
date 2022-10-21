function [ Yp ] = BlackOrWhite( s )
%Funkcija koja sluzi da obradu signala sa ligth senzora
% i prikaz da li je podloga crne ili bele boje


if s > 20
    Yp=1;
else
    Yp=-1;
end

end

