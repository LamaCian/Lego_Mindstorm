% primer kontrole motora
clc,clear
close all
handle = COM_OpenNXT('USB.ini', 'check');
COM_SetDefaultNXT(handle);



    StopMotor('all', 'off');  
    ResetMotorAngle(MOTOR_C);
    %
    ResetMotorAngle(MOTOR_B);  
% 
    SetMotor(MOTOR_C); % accesses the motor b
    SyncToMotor(MOTOR_B); % provides same controls to motor c
    SetPower 30 % power is 50 (0-100)
    SetTurnRatio 100  % if == 0 => straight forward
    SetAngleLimit 70 % how much to rotate motor shaft;

    SendMotorSettings

    WaitForMotor(MOTOR_C);
% ocitati vrednosti sa oba enkodera
    MA = GetMotorSettings(MOTOR_C)
    MB = GetMotorSettings(MOTOR_B)

StopMotor('all', 'off');