EnergyC = 160;
Pa = 0.216;
Pb = 0.0479;
% Bat1 = 25;
% C_REX = 2;
% SOC = 0.5;

cvx_begin
    variable Bat1
    variable Nc
    variable C_REX
    variable SOC
    maximize(Bat1/EnergyC + Nc/EnergyC * (1 / (Pa + Pb*C_REX*EnergyC*50/(SOC*Bat1))))
    subject to
        Bat1 > 25
        Bat1 < 40
        Nc > 0
        Nc < 10
        C_REX > 2
        C_REX < 3.1
        SOC >= 0
        SOC <= 1
cvx_end