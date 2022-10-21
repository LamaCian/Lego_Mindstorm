%TEST MOTORA

%=============================================================%
%======================== VAZNO ==============================%
%=== Ne pokreci ceo kod, vec deo po deo, za to je namenjen ===%
%=============================================================%


% Uspostavljanje komunkacije sa upravljackom jediniciom
myev3 = legoev3('usb');

%Komunkiacija sa motor, pazite na PORT!!! u koji je motor prikljucen ("A", "C")
mymotor1 = motor(myev3, 'A');              
mymotor2 = motor(myev3, 'D'); 
mymotor3 = motor(myev3, 'C'); 

% Resetovanje enkodera - Vracanje na 0
resetRotation(mymotor1);                    
resetRotation(mymotor2);

SPEED =30;  

mymotor1.Speed = SPEED; % Podesavanje brzine motora
mymotor2.Speed = -SPEED;


start(mymotor1); % Start motora
start(mymotor2);


  r1 = readRotation(mymotor1); % Ocitavanje sa enkodera
  r2 = readRotation(mymotor2);


stop(mymotor1,0);% Zaustavljanje motora
stop(mymotor2,0);


%%za treci motor
resetRotation(mymotor3);
SPEED =10;  
mymotor3.Speed = SPEED;
start(mymotor3);
stop(mymotor3,0);



