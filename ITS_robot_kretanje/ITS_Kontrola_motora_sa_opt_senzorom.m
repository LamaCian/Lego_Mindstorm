% primer kontrole motora
clc,clear
close all
handle = COM_OpenNXT('USB.ini', 'check');
COM_SetDefaultNXT(handle);
Dsr=[0];
Dsl=[0];
r = 3 % poluprecnik tocka
kk = 5
x=0; y=5; teta=0;
C = eye(3);
Cu = [0.05 0; 0 0.05];
for k = 1 : kk

    StopMotor('all', 'off');  
    ResetMotorAngle(MOTOR_B);
    %
    ResetMotorAngle(MOTOR_A);  
% 
    SetMotor(MOTOR_A); % accesses the motor b
    SyncToMotor(MOTOR_B); % provides same controls to motor c
    SetPower 50 % power is 50 (0-100)
    SetTurnRatio 0  % if == 0 => straight forward
    SetAngleLimit 100% how much to rotate motor shaft;

    SendMotorSettings

    WaitForMotor(MOTOR_A);
% ocitati vrednosti sa oba enkodera
    MA = GetMotorSettings(MOTOR_A)
    MB = GetMotorSettings(MOTOR_B)
% pretvoriti ocitavanja sa enkodera u predjeni put
    dsl = MA.Angle/57.3*r
    dsr = MB.Angle/57.3*r
    Dsr=Dsr+dsr
    Dsl=Dsl+dsl
    %[x,y,teta,C]=model_kretanja(x,y,teta,C,Cu,dsl,dsr)
    [Tow(1:2,4)]=opticki_senzor_u_w(x,y,teta)
    sv=[x y teta]';
    %plot_simulation_data(sv,C)
    
end
StopMotor('all', 'off');