clc,clear
close
%load vasa_mreza_za_modeliranje_parametra_Angle_Limit %NAJDAN
load SCnet_PR211t 
%load SCnet_PR112t
%load SCnet_PR211t
 
handle = COM_OpenNXT('USB.ini', 'check');
COM_SetDefaultNXT(handle);
%C = eye(3);
Cu = [0.05 0; 0 0.05]; %C i Cu za funkciju model kretanja
%x = [## ## ##/57.3]'    % initial state of robot. Define it!!!!
p = [0 0 0/57.3]'    % initial state of robot. Define it!!!!
C = [1 0 0;0 1 0; 0 0 1]; % initial uncertainty. Define it!!!!

% path = [40 120;50 50;85 45]; => sami odredite neku putanju. Za pocetak su
% dovoljne dve do tri tacke.
%path = [20 30;30 30];%dve tacke
%path = [3*11.667 3*11.667];%jedna tacka-NACRTAN SLUCAJ
path = [40 40];

sizpath = size(path,1);
StopMotor all off
ResetMotorAngle(MOTOR_B);
ResetMotorAngle(MOTOR_C);

dMCx = 10 ; % u cm %MCx prihvatljiva translatorna greska
fiMCx = 40; % u stepeniMC  %MCx prihvatljiva ugaona greska
dmin = 0.5; %min prihvatljiva translatorna greska
fimin = 0 ;%min prihvatljiva ugaona greska
r = 3; %poluprecnik tocka robota
% r = 2.75
%POMOCU FUNKCIJE SE ODREDJUJE UGAO SKRETANJA NA OSNOVU POCETNOG POLOZAJA
%ROBOTA
P=[];
for k = 1 : sizpath %broj tacaka

    StopMotor('all', 'off');
    ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_C);
    % ove dve funkcije kao ulaz podrazumevaju da je x vektor stanja robota
%     x = [xrobota yrobota tetarobota] pa transponovano (vektor kolona).
    d = ITS_compute_distance(p, path(k,:))
    fi = ITS_compute_direction(p,path(k,:))*57.3

    if fi <= 0
        trrot = -100;
    else trrot = 100;
    end
%-100 i 100 rotira u mestu
    if abs(fi) >= fiMCx %u startu je u toleranciji ide pravo, ako nije u toleranciji skrece za ugao iz mreze
        
        %alrot = round(sim(VASA_MREZA_ZA_ANGLE_LIMIT,fi))
        alrot = round(sim(SCnet_PR211t,fi));%round zaokruzuje na celu vrednost

        StopMotor('all', 'off');
        ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_C);
        SetMotor(MOTOR_C); %  motor A
        SyncToMotor(MOTOR_B); % motor B
        SetPower 30 %
        SetTurnRatio (trrot)  % Obratiti paznju na ovu
        SetAngleLimit (alrot) % kao i na ovu funkciju!
%         Pozivamo alrot iz VASA_MREZA_ZA_ANGLE_LIMIT

        SendMotorSettings
    pause(1)
        WaitForMotor(MOTOR_C);
        pause(1)
        MC = GetMotorSettings(MOTOR_C);
        MB = GetMotorSettings(MOTOR_B);

        dsl = MB.Angle/57.3*r %levo za B, 
        dsr = MC.Angle/57.3*r %desno za C

%         ovde staviti vasu funkciju model kretanja
%         ...model_kretanja....
        [p,C] = model_kretanja(p(1),p(2),p(3),C,Cu,dsl,dsr)
P =[P p]
    end
    
    
     

    while d > dMCx %rastojanje izmedju trenutne i ciljne(zadate tacke) tacaka iz funkcije, dMCx mi zadali 

        StopMotor('all', 'off');
        ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_C);
        SetMotor(MOTOR_C); % accesses the motor b
        SyncToMotor(MOTOR_B); % provides same controls to motor c
        SetPower 100 %
        SetTurnRatio 0%
        SetAngleLimit 80%
        pause(1)
        SendMotorSettings

        pause(1)

        MC = GetMotorSettings(MOTOR_C);
        MB = GetMotorSettings(MOTOR_B);

        dsl = MB.Angle/57.3*r
        dsr = MC.Angle/57.3*r

%         ovde staviti vasu funkciju model kretanja
%         ...model_kretanja....
        [p,C] = model_kretanja(p(1),p(2),p(3),C,Cu,dsl,dsr)
        P =[P p]
        %p=[x y teta]';%umesto najdanovog x mi p
%    Napomena: x = [xrobota yrobota tetarobota] pa transponovano (vektor kolona).
%         d = ITS_compute_distance(x, path(k,:))
%         fi = ITS_compute_direction(x,path(k,:))*57.3
%         plot_simulation_data(x, C),hold on;

         %d = ITS_compute_distance(p, path(k,:))
         fi = ITS_compute_direction(p,path(k,:))*57.3
         plot_simulation_data(p, C),hold on;
    
%         if d <= dmin | abs(fi) >= fimin
         %if  abs(fi) >= fimin & abs(fi) <= fiMCx
         %end
     %end %while
     
         if fi >= 0 & abs(fi) > fiMCx  %sa koje je strane;
                trrot = 100
                %alrot = round(sim(mreza,fi))
            alrot = round(sim(SCnet_PR211t,fi))
            StopMotor('all', 'off');
            ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_C);
            SetMotor(MOTOR_C);
            SyncToMotor(MOTOR_B);
            SetPower 30 %
            SetTurnRatio (trrot)  %
            SetAngleLimit (alrot) %
            SendMotorSettings
            pause(1)
            WaitForMotor(MOTOR_C);
            pause(1)
            MC = GetMotorSettings(MOTOR_C);
            MB = GetMotorSettings(MOTOR_B);

            dsl = MB.Angle/57.3*r
            dsr = MC.Angle/57.3*r

%         ovde staviti vasu funkciju model kretanja
%         ...model_kretanja....
        [p,C] = model_kretanja(p(1),p(2),p(3),C,Cu,dsl,dsr)
        P =[P p]
    
         else fi <= 0 & abs(fi) > fiMCx 
                trrot = -100
                 %alrot = round(sim(mreza,fi))
            alrot = round(sim(SCnet_PR211t,fi))
            StopMotor('all', 'off');
            ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_C);
            SetMotor(MOTOR_C);
            SyncToMotor(MOTOR_B);
            SetPower 30 %
            SetTurnRatio (trrot)  %
            SetAngleLimit (alrot) %
            SendMotorSettings
            pause(1)
            WaitForMotor(MOTOR_C);
            pause(1)
            MC = GetMotorSettings(MOTOR_C);
            MB = GetMotorSettings(MOTOR_B);

            dsl = MB.Angle/57.3*r
            dsr = MC.Angle/57.3*r

%         ovde staviti vasu funkciju model kretanja
%         ...model_kretanja....
        [p,C]=model_kretanja(p(1),p(2),p(3),C,Cu,dsl,dsr)
        P =[P p]
         end%if
           d = ITS_compute_distance(p, path(k,:))
         continue %go back to the MCin while loop
            
  end %while
        
 end %for


    %end%while
    StopMotor('all', 'off');
    ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_C);


%end%for; end of the MCin loop

%umesto MA MC
%MOTOR_A stavljeno MOTOR C 1.12.2009.

