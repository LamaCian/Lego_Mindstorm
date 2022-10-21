% testiranje optickog senzora
clc,clear
close all
handle = COM_OpenNXT('USB.ini', 'check');
COM_SetDefaultNXT(handle);
OpenLight(SENSOR_1,'ACTIVE'); % SENSOR_X => X = broj porta na koji je prikljucen opticki senzor
 load opt_sens_prepoznavanje_bojeff
% load perceptron VN mrezu za prepoznavanje boje
 load crna_boja2
 load bela_boja3
 min_black = min(crna_boja2)
 max_white = max(bela_boja3)
kmax = 20 %=> gornja granica broja iteracija 

for k = 1 : kmax

    StopMotor('all', 'off');  
    ResetMotorAngle(MOTOR_B);
    %
    ResetMotorAngle(MOTOR_C);  
% 
    SetMotor(MOTOR_C); % accesses the motor b
    SyncToMotor(MOTOR_B); % provides same controls to motor c
    SetPower 30 % power is 50 (0-100)
    SetTurnRatio 0  % if == 0 => straight forward
    SetAngleLimit 10% how much to rotate motor shaft;

    SendMotorSettings

    WaitForMotor(MOTOR_C);
    
% ocitati vrednosti sa optickog senzora
      s = GetLight(SENSOR_1)
      
% generisati izlaz iz vestacke neuronske mreze
      y = 2*(s-min_black)/(max_white-min_black) -1;
      o = sim(opt_sens_prepoznavanje_bojeff,y)
end
StopMotor('all', 'off');