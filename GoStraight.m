function [ r1,r2] = GoStraight(PP, mymotor1, mymotor2 )
%PID kontoler za kretanje LEGO EV3 mobilnog robota
%   
D=43;% PRECNIK TOCKA U MM
MaxSPEED=20;
if PP>0 % UKOLIKO SE KRECE U NAPRED
    SPEED =MaxSPEED;% Motor speed
    a=1;
else   % UKOLIKO SE KRECE U NAZAD
    SPEED =-MaxSPEED;% Motor speed
    a=-1;
end




Fi=round(PP*360/(pi*D)); % Odredjivanje ugla vratila koji za koji treba motor da rotira
% Uzgon=Fi/5;

resetRotation(mymotor1);                    % Reset motor rotation counter
resetRotation(mymotor2);



mymotor1.Speed = SPEED;                     % Set motor speed
mymotor2.Speed = SPEED;

start(mymotor1);                            % Start motor
start(mymotor2);



%OPERACIJE
% error_old=0;
% E=0;
kP=1;
% kD=0.1;
% kI=1;
if a==1
    % IDI U NAPRED
    while 1                       
        r1 = readRotation(mymotor1);            % Read rotation counter in degrees
        r2 = readRotation(mymotor2);
        
        r=(r1+r2)/2;
        
        error=Fi-r;
%         error_dot=error-error_old;
%         E=E+error;
        SPEED=kP*error;%+kD*error_dot+kI*E
%         error_old=error;
        
        if SPEED>=MaxSPEED
            SPEED=MaxSPEED;
        elseif SPEED <=5
            break;
        end
      
        mymotor1.Speed = SPEED;                     % Set motor speed
        mymotor2.Speed = SPEED;
    end
else
    % IDI U NAZAD!
    while 1                       
        r1 = readRotation(mymotor1);           
        r2 = readRotation(mymotor2);
        
        r=(r1+r2)/2;
        
        error=Fi-r;
%         error_dot=error-error_old;
%         E=E+error;
        SPEED=kP*error;%+kD*error_dot+kI*E
%         error_old=error;
        
        if SPEED<=-MaxSPEED
            SPEED=-MaxSPEED;
        elseif SPEED >=-5
            break;
        end
        
        mymotor1.Speed = SPEED;                     % Set motor speed
        mymotor2.Speed = SPEED;
    end
end
%KRAJ

r1=double(r1);
r2=double(r2);
stop(mymotor1,0);                             % Stop motor 
stop(mymotor2,0);
end

