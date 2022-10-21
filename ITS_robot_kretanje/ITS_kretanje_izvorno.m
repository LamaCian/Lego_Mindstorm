clc,clear
close
%load vasa_mreza_za_modeliranje_parametra_Angle_Limit %NAJDAN
load SCnet_PR

handle = COM_OpenNXT('USB.ini', 'check');
COM_SetDefaultNXT(handle);
%C = eye(3);
Cu = [0.05 0; 0 0.05]; %C i Cu za funkciju model kretanja
%x = [## ## ##/57.3]'    % initial state of robot. Define it!!!!
x = [0 0 0/57.3]'    % initial state of robot. Define it!!!!
C = [1 0 0;0 1 0; 0 0 1] % initial uncertainty. Define it!!!!


% path = [40 120;50 50;85 45]; => sami odredite neku putanju. Za pocetak su
% dovoljne dve do tri tacke.
path = [20 10;30 20];%dve tacke

sizpath = size(path,1)
StopMotor all off
ResetMotorAngle(MOTOR_B);
ResetMotorAngle(MOTOR_A);

dmax = 5 % u cm %max prihvatljiva translatorna greska
fimax = 20 % u stepenima  %max prihvatljiva ugaona greska
dmin = 1 %min prihvatljiva translatorna greska
fimin = 40 %min prihvatljiva ugaona greska
r = 3 %poluprecnik tocka robota

%POMOCU FUNKCIJE SE ODREDJUJE UGAO SKRETANJA NA OSNOVU POCETNOG POLOZAJA
%ROBOTA
for k = 1 : sizpath

    StopMotor('all', 'off');
    ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_A);
    % ove dve funkcije kao ulaz podrazumevaju da je x vektor stanja robota
%     x = [xrobota yrobota tetarobota] pa transponovano (vektor kolona).
    d = ITS_compute_distance(x, path(k,:))
    fi = ITS_compute_direction(x,path(k,:))*57.3

    if fi <= 0
        trrot = 100
    else trrot = -100
    end

    if abs(fi) >= fimax
        
        %alrot = round(sim(VASA_MREZA_ZA_ANGLE_LIMIT,fi))
        alrot = round(sim(SCnet_PR,fi))

        StopMotor('all', 'off');
        ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_A);
        SetMotor(MOTOR_A); %  motor A
        SyncToMotor(MOTOR_B); % motor B
        SetPower 20 %
        SetTurnRatio (trrot)  % Obratiti paznju na ovu
        SetAngleLimit (alrot) % kao i na ovu funkciju!
%         Pozivamo alrot iz VASA_MREZA_ZA_ANGLE_LIMIT

        SendMotorSettings
        %             pause(1)
        WaitForMotor(MOTOR_A);
        pause(1)
        MC = GetMotorSettings(MOTOR_A);
        MB = GetMotorSettings(MOTOR_B);

        dsl = MC.Angle/57.3*r
        dsr = MB.Angle/57.3*r

%         ovde staviti vasu funkciju model kretanja
%         ...model_kretanja....
        [x,y,teta,C]=model_kretanja(x,y,teta,C,Cu,dsl,dsr)

    end


    while d > dmax

        StopMotor('all', 'off');
        ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_A);
        SetMotor(MOTOR_A); % accesses the motor b
        SyncToMotor(MOTOR_B); % provides same controls to motor c
        SetPower 30 %
        SetTurnRatio 0%
        SetAngleLimit 0 %
        pause(1)
        SendMotorSettings

        pause(1)

        MC = GetMotorSettings(MOTOR_A);
        MB = GetMotorSettings(MOTOR_B);

        dsl = MC.Angle/57.3*r
        dsr = MB.Angle/57.3*r

%         ovde staviti vasu funkciju model kretanja
%         ...model_kretanja....
        [x,y,teta,C]=model_kretanja(x,y,teta,C,Cu,dsl,dsr)
        p=[x y teta]';%umesto najdanovog x mi p
%    Napomena: x = [xrobota yrobota tetarobota] pa transponovano (vektor kolona).
%         d = ITS_compute_distance(x, path(k,:))
%         fi = ITS_compute_direction(x,path(k,:))*57.3
%         plot_simulation_data(x, C),hold on;

        d = ITS_compute_distance(p, path(k,:))
        fi = ITS_compute_direction(p,path(k,:))*57.3
        plot_simulation_data(p, C),hold on;
        if d <= dmin | abs(fi) >= fimin

            if fi <=0
                trrot = 100
            else trrot = -100
            end
            %alrot = round(sim(mreza,fi))
            alrot = round(sim(SCnet_PR,fi))
            StopMotor('all', 'off');
            ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_A);
            SetMotor(MOTOR_A);
            SyncToMotor(MOTOR_B);
            SetPower 20 %
            SetTurnRatio (trrot)  %
            SetAngleLimit (alrot) %
            SendMotorSettings
            pause(1)
            WaitForMotor(MOTOR_A);
            pause(1)
            MC = GetMotorSettings(MOTOR_A);
            MB = GetMotorSettings(MOTOR_B);

            dsl = MC.Angle/57.3*r
            dsr = MB.Angle/57.3*r

%         ovde staviti vasu funkciju model kretanja
%         ...model_kretanja....
        [x,y,teta,C]=model_kretanja(x,y,teta,C,Cu,dsl,dsr)

            continue % go back to the main while loop
        end%if


    end%while
    StopMotor('all', 'off');
    ResetMotorAngle(MOTOR_B); ResetMotorAngle(MOTOR_A);


end%for; end of the main loop

